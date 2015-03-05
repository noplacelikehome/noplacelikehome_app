require 'json'

# TODO: for some reason this doesn't work on the /api/offer route, disabling
# before '/api/*' do
#   params = JSON.parse(request.env["rack.input"].read)
# end

post '/api/offer' do
  params = JSON.parse(request.env["rack.input"].read)
  address_data = get_zillow_address_data(params["street_address"], params["zip"])
  unless address_data
    address_data = get_google_geocode_data(params["street_address"], params["zip"], params["bedrooms"])
  end
  new_offer = Offer.create(price: params["offer_price"].to_i, street_address: params["street_address"], zip: params["zip"].to_i, bedrooms: address_data["bedrooms"].to_i)

  # p session[:id] = new_offer.id

  args = { offer_price: params["offer_price"].to_i,
           monthly_market_value: address_data[:monthly_market_value],
           current_monthly_rent: params["current_monthly_rent"].to_i } #mmv comes from zillow, cmr & op from user

  low_offer = calculate_low_offer(args)
  high_offer = calculate_high_offer(address_data[:total_market_value])

  orig_total_after_taxes = calculate_total_after_taxes(params["offer_price"].to_i, params["yearly_income"].to_i)
  low_total_after_taxes = calculate_total_after_taxes(low_offer, params["yearly_income"].to_i)
  high_total_after_taxes = calculate_total_after_taxes(high_offer, params["yearly_income"].to_i)

  orig_difference_in_months = calculate_difference_in_months(orig_total_after_taxes, address_data[:monthly_market_value], params["current_monthly_rent"].to_i).to_s
  low_difference_in_months = calculate_difference_in_months(low_total_after_taxes, address_data[:monthly_market_value], params["current_monthly_rent"].to_i).to_s
  high_difference_in_months = calculate_difference_in_months(high_total_after_taxes, address_data[:monthly_market_value], params["current_monthly_rent"].to_i).to_s

  content_type :json

  { original_offer: params["offer_price"].to_i, low_offer: calculate_low_offer(args), high_offer:
  calculate_high_offer(address_data[:total_market_value]), orig_total_after_taxes: orig_total_after_taxes, orig_difference_in_months: orig_difference_in_months.to_i, low_total_after_taxes: low_total_after_taxes, low_difference_in_months: low_difference_in_months.to_i, high_total_after_taxes: high_total_after_taxes, high_difference_in_months: high_difference_in_months.to_i }.to_json
end

# TESTING PURPOSES ONLY
get '/address_data' do
  content_type :json
  get_zillow_address_data("725 Leavenworth", "94110").to_json
end

get '/market_data' do
  content_type :json
  zillow_market_value_lookup("Marina", 4).to_json
end

#test route - can use params ?offer_price=25000&yearly_income=40000&current_monthly_rent=1000
get '/taxes' do
  content_type :json
  total_after_taxes = calculate_total_after_taxes(params[:offer_price].to_i, params[:yearly_income].to_i)
  address_data = get_zillow_address_data("725 Leavenworth", "94110")
  diff_in_months = calculate_difference_in_months(total_after_taxes, address_data[:monthly_market_value], params[:current_monthly_rent].to_i).to_s
  diff_in_months.to_json
end


# first page questionaire - are you afraid of being evicted?
post '/api/evictions' do
  params = JSON.parse(request.env["rack.input"].read)
  session[:id]
  offer = Offer.find(session[:id])
  update_offer = offer.update_attributes(fear_eviction: params[:eviction])
end

post '/api/summons' do
  params = JSON.parse(request.env["rack.input"].read)
  offer = Offer.find(session[:id])
  update_offer = offer.update_attributes(summons: params[:summons])
end

post '/api/people' do
  params = JSON.parse(request.env["rack.input"].read)
  offer = Offer.find(session[:id])
  update_offer = offer.update_attributes(has_children: params[:children], disabled: params[:disabled], has_elderly: params[:elderly])
  # redirect "/api/display_buyout_analysis"
end

post '/api/neighbors' do
  offer = Offer.find(session[:id])
  update_offer = offer.update_attributes(other_apts_status: params[:other_apts_status])
end

post '/api/neighbor-people' do
  offer = Offer.find(session[:id])
  update_offer = offer.update_attributes(other_apts_children_elderly_disabled: params[:other_apts_status])
end

post '/api/resources' do
  @offer = Offer.find(session[:id])
  # then pass the offer complete details to render in the graphical analysis
end

# get '/tax' do
#   # calculate_difference_in_months(total_after_taxes, address_data[:monthly_market_value]).to_s
#   calculate_difference_in_months(total_after_taxes, 4567, 2500).to_s
# end
