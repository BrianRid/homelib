class AddColumnsToIncidents < ActiveRecord::Migration[5.2]
  def change
    add_column :incidents, :reparation, :string
    add_column :incidents, :tarif, :string
    add_column :incidents, :responsable, :string
    add_column :incidents, :last_answer, :string
  end
end
