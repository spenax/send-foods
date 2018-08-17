class Payment < ApplicationRecord
  has_many :messages

  BASE_URL = "https://venmo.com/api/v5/public?limit=50"

class << self
  def req(url)
    request = Faraday.get(url)
    JSON.parse(request.body)["data"]
    #outputs an array of hashes
  end

  def get_simple_parse
    recent_trans = self.req(BASE_URL)
  end
end





  #You will probably need to move the Requests and imports over here
end
