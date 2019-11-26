class ModifyTypesInTypeToIncidents < ActiveRecord::Migration[5.2]
  def change
    rename_column :incidents, :types, :type
  end
end
