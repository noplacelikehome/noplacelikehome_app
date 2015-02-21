class CreateOffers < ActiveRecord::Migration

  def change
    add_column :offers, :summons, :boolean
    add_column :offers, :other_apts_status, :boolean
    add_column :offers, :other_apts_children_elderly_disabled, :boolean
  end

end