class CreateIncidents < ActiveRecord::Migration[5.2]
  def change
    create_table :incidents do |t|
      t.references :flat, foreign_key: true
      t.date :date
      t.string :status, default: "pending"
      t.string :dispo

      t.timestamps
    end
  end
end
