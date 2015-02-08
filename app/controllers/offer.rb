get '/offer' do
  p monthly_market_value = get_zillow_address_data("725 Leavenworth", "94110")
  args = { offer_price: 25_000,
           monthly_market_value: monthly_market_value.to_i,
           current_monthly_rent: 2500 } #mmv comes from zillow, cmr & op from user
  calculate_low_offer(args).to_s
end

get '/address_data' do
  content_type :json
  get_zillow_address_data("725 Leavenworth", "94110").to_json

end


get '/api/get_offer_price' do

end