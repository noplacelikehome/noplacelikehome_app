post '/api/offer' do
  new_offer = Offer.create(price: params[:offer_price].to_i, street_address: params[:street_address], zip: params[:zip].to_i, bedrooms: params[:bedrooms].to_i)
  session[:id] = new_offer.id
  address_data = get_zillow_address_data(params[:street_address], params[:zip])
  args = { offer_price: params[:offer_price],
           monthly_market_value: address_data[:monthly_market_value],
           current_monthly_rent: params[:current_monthly_rent] } #mmv comes from zillow, cmr & op from user
  total_after_taxes = calculate_total_after_taxes(params[:offer_price], params[:yearly_income])
  difference_in_months = calculate_difference_in_months(total_after_taxes, address_data[:monthly_market_value], params[:current_monthly_rent]).to_s
  content_type :json
  { low_offer: calculate_low_offer(args), high_offer:
  calculate_high_offer(address_data[:total_market_value]), difference_in_months: difference_in_months }.to_json
end

# get '/address_data' do
#   content_type :json
#   get_zillow_address_data("725 Leavenworth", "94110").to_json
# end

# first page questionaire
get '/api/get_eviction_status' do
  offer = Offer.find(session[:id])
  update_offer = offer.update_attribute(fear_eviction: to_boolean(params[:eviction]))
  if update_offer.fear_eviction
    redirect "/api/get_eviction_info"
  else
    redirect "/api/months_lasts"
  end
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

# get '/tax' do
#   # calculate_difference_in_months(total_after_taxes, address_data[:monthly_market_value]).to_s
#   calculate_difference_in_months(total_after_taxes, 4567, 2500).to_s
# end
