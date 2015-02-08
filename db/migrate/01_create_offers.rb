class CreateOffers < ActiveRecord::Migration

  def change
    create_table :offers do |t|
      t.integer  :price
      t.string   :address
      t.boolean  :fear_eviction
      t.integer  :bedrooms
      t.boolean  :has_elderly
      t.boolean  :has_children
      t.boolean  :disabled

      t.timestamps
    end
  end

end