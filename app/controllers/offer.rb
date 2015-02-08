get '/offer' do
  args = { offer_price: 25_000,
           monthly_market_value: 4621, 
           current_monthly_rent: 2500 } #mmv comes from zillow, cmr & op from user
  calculate_low_offer(args).to_s
end