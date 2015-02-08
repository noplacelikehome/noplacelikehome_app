# Input: offer price for the property, median house value based on that location, current monthly price for the location
#   -> requires API call to the Zillow API.
# Output:
#

helpers do
  def calculate_market_rate_difference(monthly_market_value, current_monthly_rent)
    return (monthly_market_value - current_monthly_rent)*24
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

  def calculate_ca_tax_impact(offer_price, income_level)
    total_taxable = income_level + offer_price
    if income_level > 1_000_000
      return 0.133
    elsif income_level > 508_500
      return 0.123
    elsif income_level > 305_100
      return 0.113
    elsif income_level > 254_250
      return 0.103
    elsif income_level > 49_774
      return 0.093
    elsif income_level > 39_384
      return 0.08
    elsif income_level > 28_371
      return 0.06
    elsif income_level > 17_976
      return 0.04
    elsif income_level > 7_582
      return 0.02
    else
      return 0.01
    end
  end

  def calculate_fed_tax_impact(offer_price, income_level)
    total_taxable = income_level + offer_price
    if income_level > 406_751
      return 0.396
    elsif income_level > 405_101
      return 0.35
    elsif income_level > 186_351
      return 0.33
    elsif income_level > 89_351
      return 0.28
    elsif income_level > 36_901
      return 0.25
    elsif income_level > 9_076
      return 0.15
    else
      return 0.10
    end
  end

  def calculate_total_after_taxes(offer_price, income_level)
    total_taxes = calculate_fed_tax_impact(offer_price, income_level) + calculate_ca_tax_impact(offer_price, income_level)
    return offer_price - (total_taxes*offer_price)
  end

  def calculate_difference_in_months(total_after_taxes, monthly_market_value, current_monthly_rent)
    rent_difference = monthly_market_value -  current_monthly_rent
    total_after_taxes/rent_difference
  end
end