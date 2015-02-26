require 'httparty'
require 'uri'
require 'pp'

helpers do
  def get_zillow_address_data(address, zipcode)
    address = URI.encode(address)
    response = HTTParty.get("http://www.zillow.com/webservice/GetDeepSearchResults.htm?zws-id=X1-ZWz1az0o6cmnm3_8b748&address=#{address}&citystatezip=#{zipcode}&rentzestimate=true")
    # p response["searchresults"]["response"]
    if response["searchresults"]["response"]
      result = response["searchresults"]["response"]["results"]["result"][0]
      monthly_market_value = result["rentzestimate"]["amount"]["__content__"]
      total_market_value = result["zestimate"]["amount"]["__content__"]
      # pp result["bedrooms"]
      return { monthly_market_value: monthly_market_value.to_i, total_market_value: total_market_value.to_i, bedrooms: result["bedrooms"].to_i}
    else
      return false
    end
  end

  def to_boolean(string)
    string == 'true'
  end

  def get_google_geocode_data(address, zipcode, bedrooms)
    url = URI.encode("https://maps.googleapis.com/maps/api/geocode/json?address=#{address},+San+Francisco,+CA&key=AIzaSyCsUnnbPXOHFnO1BmsSMlNxuGYFz-UUOJ8")
    response = HTTParty.get(url)
    p response
    neighborhood = response["results"][0]["address_components"][2]["long_name"]
    p neighborhood
    p average_neighborhood_price(neighborhood, bedrooms.to_i)
  end

  def average_neighborhood_price(neighborhood, bedrooms)

    neighborhoods = {
      "Alamo Square" => { 0 => 2295, 1 => 2995, 2 => 2975, 3 => 5940 },
      "Bayview" => { 0 => 1425, 1 => 1425, 2 => 2650, 3 => 3500 },
      "Bernal Heights" => { 0 => 3390, 1 => 3390, 2 => 3525, 3 => 4900 },
      "Castro" => { 0 => 1900, 1 => 3498, 2 => 4200, 3 => 6250 },
      "Civic Center" => { 0 => 2248, 1 => 3400, 2 => 4998, 3 => 4500 },
      "Cole Valley" => { 0 => 1988, 1 => 2700, 2 => 4150, 3 => 6500 },
      "Excelsior" => { 0 => 1825, 1 => 1825, 2 => 2550, 3 => 3200 },
      "Financial District" => { 0 => 2750, 1 => 3600, 2 => 5950, 3 => 9540 },
      "Glen Park" => { 0 => 2163, 1 => 2163, 2 => 3800, 3 => 5800 },
      "Haight Ashbury" => { 0 => 1750, 1 => 2800, 2 => 3650, 3 => 6425 },
      "Hayes Valley" => { 0 => 1900, 1 => 3750, 2 => 4650, 3 => 5200 },
      "Ingleside" => { 0 => 1600, 1 => 2241, 2 => 2900, 3 => 3850 },
      "Inner Richmond" => { 0 => 1525, 1 => 2193, 2 => 3000, 3 => 3995 },
      "Inner Sunset"  => { 0 => 1700, 1 => 2100, 2 => 3190, 3 => 4000 },
      "Laurel Heights"  => { 0 => 2350, 1 => 2700, 2 => 4000, 3 => 6200 },
      "Lower Haight" => { 0 => 1950, 1 => 3000, 2 => 4295, 3 => 5295 },
      "Lower Nob Hill" => { 0 => 2201, 1 => 3050, 2 => 3899, 3 => 3950 },
      "Lower Pac Heights" => { 0 => 2000, 1 => 3125, 2 => 4125, 3 => 5500 },
      "Marina" => {0 => 2125, 1 => 3175, 2=> 4625, 3 => 6750},
      "Mission District" => {0 => 2498 , 1 => 3250, 2=> 4190, 3 => 5146},
      "Nob Hill" => {0 => 2095, 1 => 3180, 2=> 4275, 3 => 5995},
      "Noe Valley" => {0 => 1500, 1 => 2875, 2=> 4000, 3 => 5500},
      "North Beach" => {0 => 2325, 1 => 3050, 2=> 4300, 3 => 6575},
      "Pacific Heights" => {0 => 2000, 1 => 3250, 2=> 4500, 3 => 6700},
      "Panhandle" => {0 => 1848, 1 => 2750, 2=> 3495, 3 => 4575},
      "Portola District" => {0 => 1625, 1 => 1625, 2=> 2825, 3 => 3498},
      "Potrero Hill" => {0 => 2850, 1 => 3325, 2=> 4300, 3 => 5650},
      "Richmond" => {0 => 1600, 1 => 1995, 2=> 2995, 3 => 3995},
      "Russian Hill" => {0 => 1998, 1 => 3273, 2=> 4900, 3 => 5998},
      "South of Market" => {0 => 2917, 1 => 3359, 2=> 4800, 3 => 6999},
      "Sunset" => {0 => 1075, 1 => 1725, 2=> 2895, 3 => 3573},
      "Tenderloin" => {0 => 1595, 1 => 1605, 2=> 3395, 3 => 3395},
      "Twin Peaks" => {0 => 2523, 1 => 2523, 2=> 3999, 3 => 4100},
      "Visitacion Valley" => {0 => 1750, 1 => 1750, 2=> 2492, 3 => 2898},
      "West Portal" => {0 => 2100, 1 => 2100, 2=> 2748, 3 => 4975},
      "Western Addition" => {0 => 1725, 1 => 2400, 2=> 3450, 3 => 3950}
    }
    p neighborhoods[neighborhood][bedrooms]
  end


end