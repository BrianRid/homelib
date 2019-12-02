class AddColumnToIncidents < ActiveRecord::Migration[5.2]
  def change
    add_column :incidents, :comment, :text
  end
end
