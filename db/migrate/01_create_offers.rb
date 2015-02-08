class CreateOffers < ActiveRecord::Migration

  def change
    create_table :offers do |t|
      t.integer  :price
      t.string   :address
      t.integer  :bedrooms

      t.timestamps
    end
  end

end