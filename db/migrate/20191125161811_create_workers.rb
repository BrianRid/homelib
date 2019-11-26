class CreateWorkers < ActiveRecord::Migration[5.2]
  def change
    create_table :workers do |t|
      t.string :name
      t.string :phone
      t.string :email
      t.string :categories

      t.timestamps
    end
  end
end
