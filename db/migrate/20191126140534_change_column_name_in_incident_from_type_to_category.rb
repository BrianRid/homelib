class ChangeColumnNameInIncidentFromTypeToCategory < ActiveRecord::Migration[5.2]
  def change
    rename_column :incidents, :type, :category
  end
end
