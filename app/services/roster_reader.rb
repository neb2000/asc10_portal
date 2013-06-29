require "net/http"
require "uri"
class RosterReader
  include Virtus
  
  attribute :url,   String
  attribute :ranks, Array[Integer]
  
  def uri(klass = URI)
    @uri = klass.parse(url)
  end
  
  def response(klass = Net::HTTP)
    klass.get_response(uri)
  end
  
end