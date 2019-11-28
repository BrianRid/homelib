class AddDescriptionAndAddressToWorkers < ActiveRecord::Migration[5.2]
  def change
    add_column :workers, :description, :text
    add_column :workers, :address, :string
  end
end
