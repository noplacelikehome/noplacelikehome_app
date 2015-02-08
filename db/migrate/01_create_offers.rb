class CreateOffers < ActiveRecord::Migration

  def change
    create_table :offers do |t|
      t.integer  :price
      t.string   :street_address
      t.string   :city
      t.string   :state
      t.integer  :zip
      t.boolean  :fear_eviction
      t.integer  :bedrooms
      t.boolean  :has_elderly
      t.boolean  :has_children
      t.boolean  :disabled

      t.timestamps
    end
  end

end