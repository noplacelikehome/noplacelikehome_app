require 'httparty'
require 'uri'

helpers do
  def get_zillow_address_data(address, zipcode)
    address = URI.encode(address)
    response = HTTParty.get("http://www.zillow.com/webservice/GetDeepSearchResults.htm?zws-id=X1-ZWz1az0o6cmnm3_8b748&address=#{address}&citystatezip=#{zipcode}&rentzestimate=true")
    response["searchresults"]["response"]["results"]["result"][0]["rentzestimate"]["amount"]["__content__"]
    # return response
  end

end