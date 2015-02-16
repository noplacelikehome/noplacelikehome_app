get '/map' do
  @mapData = [
    {
      "type" => "FeatureCollection",
      "features" => []
     }
  ]
  offers = Offer.all
  offers.each do |offer|
      geoJSON = {
         "type" => "Feature",
         "geometry" => {
             "type" => "Point",
             "coordinates" => [offer.longitude, offer.latitude]
          },
          "properties" => {
                "address" => "#{offer.street_address}, San Francisco, CA",
                "price" => offer.price,
                "bedrooms" => offer.bedrooms
          }
      }
      @mapData[0]["features"].push(geoJSON)
  end
  erb :index
end