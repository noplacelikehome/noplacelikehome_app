require "geocoder"


get '/map' do
  @mapData = [
    {
      "type" => "FeatureCollection",
      "features" => []
     }
  ]
  offers = Offer.all
  offers.each do |offer|
    full_address = "#{offer.street_address}, San Francisco, CA"
    coordinates = Geocoder.coordinates(full_address)
    sleep(0.4)
    long = coordinates[0]
    lat = coordinates[1]
    new_coordinates = []
    new_coordinates[0] = lat
    new_coordinates[1] = long
      geoJSON = {
         "type" => "Feature",
         "geometry" => {
             "type" => "Point",
             "coordinates" => new_coordinates
          },
          "properties" => {
                "address" => full_address,
                "price" => offer.price,
                "bedrooms" => offer.bedrooms
          }
      }
      @mapData[0]["features"].push(geoJSON)
  end
  erb :index
end