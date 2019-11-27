class ChangeRentToLoyerInRental < ActiveRecord::Migration[5.2]
  def change
     change_column :rentals, :rent, :integer
  end
end
