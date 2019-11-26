class CreateRentals < ActiveRecord::Migration[5.2]
  def change
    create_table :rentals do |t|
      t.references :user, foreign_key: true
      t.references :flat, foreign_key: true
      t.date :start_date
      t.integer :duration, default: 3
      t.integer :rent

      t.timestamps
    end
  end
end
