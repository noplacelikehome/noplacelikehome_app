get '/offer' do
  address_data = get_zillow_address_data("725 Leavenworth", "94110")
  # offer = Offer.new(qweqweqw)
  # session[:offer_id] = offer.id
  args = { offer_price: 25_000,
           monthly_market_value: address_data[:monthly_market_value],
           current_monthly_rent: 2500 } #mmv comes from zillow, cmr & op from user
  content_type :json
  { low_offer: calculate_low_offer(args), high_offer:
  calculate_high_offer(address_data[:total_market_value]) }.to_json
end

post '/occupants' do
  offer= Offer.find(session[:offer_id])
  # offer.update_attributes(children: false)
end

get '/address_data' do
  content_type :json
  get_zillow_address_data("725 Leavenworth", "94110").to_json

end


get '/api/get_offer_price' do

end