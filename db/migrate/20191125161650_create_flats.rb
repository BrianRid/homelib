class CreateFlats < ActiveRecord::Migration[5.2]
  def change
    create_table :flats do |t|
      t.references :user, foreign_key: true
      t.string :address
      t.text :description
      t.integer :nb_rooms, default: 1
      t.integer :area
      t.boolean :furnished, default: false
      t.string :syndic_name
      t.string :syndic_phone
      t.string :syndic_email

      t.timestamps
    end
  end
end
