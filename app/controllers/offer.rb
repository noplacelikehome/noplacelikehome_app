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

# made some form input assumptions for all params
# first page questionaire
get '/api/get_offer_price' do
  new_offer = Offer.create(price: params[:offer_price].to_i, street_address: params[:street_address], zip: params[:zip].to_i, bedrooms: params[:bedrooms].to_i)
  session[:id] = new_offer.id
end

get '/api/get_eviction_status' do
  offer = Offer.find(session[:id])
  update_offer = offer.update_attribute(fear_eviction: to_boolean(params[:eviction]))
  if update_offer.fear_eviction
    redirect "/api/get_eviction_info"
  else
    redirect "/api/months_lasts"
  end
end

get '/api/months_lasts' do
  # input Jesse's algo for how many months the buyout can last in neighborhood
end

get '/api/get_eviction_info' do
  offer = Offer.find(session[:id])
  update_offer = offer.update_attributes(has_children: to_boolean(params[:children]), disabled: to_boolean(params[:disabled]), has_elderly: to_boolean(params[:elderly]))
  redirect "/api/display_buyout_analysis"
end

get '/api/display_buyout_analysis' do
  @offer = Offer.find(session[:id])
  # then pass the offer complete details to render in the graphical analysis
end

get '/tax' do
  total_after_taxes = calculate_total_after_taxes(25_000, 150_000)
  # calculate_difference_in_months(total_after_taxes, address_data[:monthly_market_value]).to_s
  calculate_difference_in_months(total_after_taxes, 4567, 2500).to_s
end
