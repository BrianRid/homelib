class ChangeColumnIncidentStatus < ActiveRecord::Migration[5.2]
  def change
    change_column_default :incidents, :status, from: "pending", to: "En cours"
  end
end
