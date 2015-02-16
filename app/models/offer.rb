class Offer < ActiveRecord::Base
  geocoded_by :full_street_address
  after_validation :geocode

  def full_street_address
    "#{self.street_address}, San Francisco, CA"
  end

end