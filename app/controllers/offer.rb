require 'json'

post '/api/offer' do
  params = JSON.parse(request.env["rack.input"].read)
  puts params
  puts "*" * 800
  address_data = get_zillow_address_data(params["street_address"], params["zip"])
  if address_data
    new_offer = Offer.create(price: params["offer_price"].to_i, street_address: params["street_address"], zip: params["zip"].to_i, bedrooms: address_data["bedrooms"])
    session[:id] = new_offer.id
    args = { offer_price: params["offer_price"].to_i,
             monthly_market_value: address_data[:monthly_market_value],
             current_monthly_rent: params["current_monthly_rent"].to_i } #mmv comes from zillow, cmr & op from user
    total_after_taxes = calculate_total_after_taxes(params["offer_price"].to_i, params["yearly_income"].to_i)
    difference_in_months = calculate_difference_in_months(total_after_taxes, address_data[:monthly_market_value], params["current_monthly_rent"].to_i).to_s
    content_type :json
    { low_offer: calculate_low_offer(args), high_offer:
    calculate_high_offer(address_data[:total_market_value]), total_after_taxes: total_after_taxes, difference_in_months: difference_in_months.to_i }.to_json
  else
    content_type :json
    { error: "Address not found"}.to_json
  end
end
# number of bedrooms can come from zillow

get '/address_data' do
  content_type :json
  get_zillow_address_data("725 Leavenworth", "94110").to_json
end

#test route - can use params ?offer_price=25000&yearly_income=40000&current_monthly_rent=1000
get '/taxes' do
  content_type :json
  total_after_taxes = calculate_total_after_taxes(params[:offer_price].to_i, params[:yearly_income].to_i)
  address_data = get_zillow_address_data("725 Leavenworth", "94110")
  diff_in_months = calculate_difference_in_months(total_after_taxes, address_data[:monthly_market_value], params[:current_monthly_rent].to_i).to_s
  # address_data.to_json
  # calculate_high_offer(address_data[:total_market_value]).to_json
  # total_after_taxes.to_json
  diff_in_months.to_json
end


# first page questionaire
post '/api/get_eviction_status' do
  offer = Offer.find(session[:id])
  update_offer = offer.update_attribute(fear_eviction: to_boolean(params[:eviction]))
  if update_offer.fear_eviction
    redirect "/api/get_eviction_info"
  else
    redirect "/api/months_lasts"
  end
end

post '/api/get_eviction_info' do
  offer = Offer.find(session[:id])
  update_offer = offer.update_attributes(has_children: to_boolean(params[:children]), disabled: to_boolean(params[:disabled]), has_elderly: to_boolean(params[:elderly]))
  redirect "/api/display_buyout_analysis"
end

post '/api/display_buyout_analysis' do
  @offer = Offer.find(session[:id])
  # then pass the offer complete details to render in the graphical analysis
end

# get '/tax' do
#   # calculate_difference_in_months(total_after_taxes, address_data[:monthly_market_value]).to_s
#   calculate_difference_in_months(total_after_taxes, 4567, 2500).to_s
# end
