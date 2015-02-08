10.times do
  Offer.create(price: rand(900..80000), street_address: rand(1..4000).to_s + " Market Street", city: "San Francisco", state: "CA", bedrooms: rand(0..4))
end