class CreateRents < ActiveRecord::Migration[5.2]
  def change
    create_table :rents do |t|
      t.references :rental
      t.string :status, default: "pending"
      t.date :date

      t.timestamps
    end
  end
end
