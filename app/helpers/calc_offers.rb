# Input: offer price for the property, median house value based on that location, current monthly price for the location
#   -> requires API call to the Zillow API.
# Output: 
# 

helpers do
  def calculate_market_rate_difference(monthly_market_value, current_monthly_rent)
    return monthly_market_value*24-current_monthly_rent*24 #gives the difference that will have to be covered
  end

  def calculate_low_offer(args) #market_value, current_rent, offer_price
    compensation_required = calculate_market_rate_difference(args[:monthly_market_value], args[:current_monthly_rent])
    if compensation_required > 50_000
      compensation_required = 50_000
    end
    return compensation_required
    # current_rent
    # offer_price
    #calculate low offer is based on the two year, capped at $50,000. 

  end

  def calculate_high_offer

  end

end