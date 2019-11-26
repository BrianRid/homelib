class CreateUserWorkers < ActiveRecord::Migration[5.2]
  def change
    create_table :user_workers do |t|
      t.references :worker, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
