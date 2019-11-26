class AddTypesColToIncidents < ActiveRecord::Migration[5.2]
  def change
    add_column :incidents, :types, :string
  end
end
