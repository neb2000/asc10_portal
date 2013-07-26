require 'net/http'
require 'uri'
require 'json'
class RosterReader
  include Virtus
  
  attribute :url,       String
  attribute :ranks,     Array[Integer]
  attribute :min_level, Integer, default: 90
  
  WOW_CLASS = {
    1 =>  'warrior',
    2 =>  'paladin',
    3 =>  'hunter',
    4 =>  'rogue',
    5 =>  'priest',
    6 =>  'deathknight',
    7 =>  'shaman',
    8 =>  'mage',
    9 =>  'warlock',
    10 => 'monk',
    11 => 'druid'
  }
    
  def filtered_members
    member_list = Hash.new { |hash, key| hash[key] = [] }
    roster_list.each do |character|
      character_info = character['character']
      if (ranks.member? character['rank'].to_i) && (character_info['level'].to_i >= min_level) && (character_info['spec'])
        member_list[character_info['spec']['role']] << { name: character_info['name'], class: WOW_CLASS[character_info['class']] }
      end
    end
    member_list
  end
    
  def roster_list(klass = JSON)
    return [] unless response.code.to_i == 200
    @roster_list ||= klass.parse(response.body)['members']
  end
  
  def uri(klass = URI)
    @uri ||= klass.parse(url)
  end
  
  def response(klass = Net::HTTP)
    @response ||= klass.get_response(uri)
  end
end