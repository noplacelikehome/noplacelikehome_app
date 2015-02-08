require "geocoder"

get '/' do
  "hey"
end

get '/map' do
  @mapData = [
    {
      "type": "Feature",
      "features": []

     }
  ]
  offers = Offer.all
  offers.each do |offer|
    full_address = "#{offer.street_address}, #{offer.city}, #{offer.state}"
    coordinates = Geocoder.coordinates(full_address)
      geoJSON = {
         "type": "Feature",
         "geometry": {
             "type": "point",
             "coordinates": coordinates
          },
          "properties": {
                "address": full_address
          }
      }
      p @mapData
      p @mapData[0]
      p @mapData[0][:features]
      @mapData[0][:features].push(geoJSON)
  end
  erb :index
end