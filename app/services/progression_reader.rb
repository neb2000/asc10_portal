require 'net/http'
require 'uri'
require 'json'
class ProgressionReader
  include Virtus
  
  attribute :url,       String
  attribute :raids,     Array[String]
  
  def report
    filtered_raids.map do |raid|
      normal_total  = 0
      heroic_total  = 0
      normal_killed = 0
      heroic_killed = 0
      details = []
      raid['bosses'].each do |boss|
        detail = {name: boss['name'], id: boss['id']}
        if boss.key?('normalKills') 
          if boss['normalKills'] > 0
            detail[:normal] = true
            normal_killed += 1
          end
          normal_total += 1
        end
        if boss.key?('heroicKills')
          if boss['heroicKills'] > 0
            detail[:heroic] = true
            heroic_killed += 1
          end
          heroic_total += 1
        end
        details << detail
      end
      progress = if heroic_killed == 0
        "#{normal_killed}/#{normal_total}(N)"
      else
        "#{heroic_killed}/#{heroic_total}(H)"
      end
      { name: raid['name'], progress: progress, details: details }
    end
  end
  
  def filtered_raids
    @filtered_raids ||= progression_list.select{ |raid_info| self.raids.member? raid_info['name'] }
  end
  
  def progression_list(klass = JSON)
    return [] unless response.code.to_i == 200
    @progression_list ||= klass.parse(response.body)['progression']['raids']
  end
  
  def uri(klass = URI)
    @uri ||= klass.parse(url)
  end
  
  def response(klass = Net::HTTP)
    @response ||= klass.get_response(uri)
  end
end