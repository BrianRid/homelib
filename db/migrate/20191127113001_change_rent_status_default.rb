class ChangeRentStatusDefault < ActiveRecord::Migration[5.2]
  def change
    change_column :rents, :status, :string, default: nil
  end
end
