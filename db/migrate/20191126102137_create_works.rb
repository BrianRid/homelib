class CreateWorks < ActiveRecord::Migration[5.2]
  def change
    create_table :works do |t|
      t.float :price
      t.string :comment
      t.date :date
      t.references :incident, foreign_key: true
      t.references :worker, foreign_key: true

      t.timestamps
    end
  end
end
