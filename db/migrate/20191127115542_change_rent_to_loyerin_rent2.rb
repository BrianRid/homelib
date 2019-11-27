class ChangeRentToLoyerinRent2 < ActiveRecord::Migration[5.2]
  def change
    rename_column :rentals, :rent, :loyer
  end
end
