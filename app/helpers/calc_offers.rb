# Input: offer price for the property, median house value based on that location, current monthly price for the location
#   -> requires API call to the Zillow API.
# Output: 
# 

helpers do
  def calculate_market_rate_difference(monthly_market_value, current_monthly_rent)
    return (monthly_market_value-current_monthly_rent)*24
    # ordinance requires that a landlord pays the difference between two years of rent on current market rate in an Ellis
  end

  def calculate_low_offer(args) #market_value, current_rent, offer_price
    compensation_required = calculate_market_rate_difference(args[:monthly_market_value], args[:current_monthly_rent])
    if compensation_required > 50_000
      compensation_required = 50_000
    end
    return compensation_required
  end

  def calculate_high_offer(total_market_value)
    return total_market_value*0.1394
    # According to http://priceonomics.com/how-much-should-a-landlord-pay-a-tenant-to-move/, a landlord misses out on 13.94% of a rental unit's value if it is occupied by tenants, not factoring in market value
  end



end