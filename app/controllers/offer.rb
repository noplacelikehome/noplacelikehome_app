require 'json'

post '/api/offer' do
  params = JSON.parse(request.env["rack.input"].read)

  new_offer = Offer.create(price: params["offer_price"].to_i, street_address: params["street_address"], zip: params["zip"].to_i, bedrooms: params["no_bedrooms"])

  address_data = get_zillow_address_data(params["street_address"], params["zip"])
  p address_data

  total_after_taxes = calculate_total_after_taxes(params["offer_price"].to_i, params["yearly_income"].to_i)
  if address_data

    session[:id] = new_offer.id

    args = { offer_price: params["offer_price"].to_i,
             monthly_market_value: address_data[:monthly_market_value],
             current_monthly_rent: params["current_monthly_rent"].to_i } #mmv comes from zillow, cmr & op from user


    difference_in_months = calculate_difference_in_months(total_after_taxes, address_data[:monthly_market_value], params["current_monthly_rent"].to_i).to_s

    content_type :json

    { low_offer: calculate_low_offer(args), high_offer:
    calculate_high_offer(address_data[:total_market_value]), total_after_taxes: total_after_taxes, difference_in_months: difference_in_months.to_i }.to_json

  else

    market_average_rent = get_google_geocode_data(params["street_address"], params["zip"], params["no_bedrooms"])

    difference_in_months = calculate_difference_in_months(total_after_taxes, market_average_rent, params["current_monthly_rent"].to_i).to_s

    if (market_average_rent - params["current_monthly_rent"].to_i)*24 > 50_000
      low_offer = 50_000
    else
      low_offer = (market_average_rent - params["current_monthly_rent"].to_i)*24
    end
    content_type :json

    { low_offer: low_offer, high_offer:
    "Sorry we do not have enough information for high offer estimate", total_after_taxes: total_after_taxes, difference_in_months: difference_in_months.to_i }.to_json
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


# first page questionaire - are you afraid of being evicted?
post '/api/evictions' do
  params = JSON.parse(request.env["rack.input"].read)
  offer = Offer.find(session[:id])
  update_offer = offer.update_attributes(fear_eviction: params[:eviction])
end

post '/api/summons' do
  offer = Offer.find(session[:id])
  update_offer = offer.update_attributes(summons: params[:summons])
end

post '/api/people' do
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
