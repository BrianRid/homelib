class CreateDocuments < ActiveRecord::Migration[5.2]
  def change
    create_table :documents do |t|
      t.string :name
      t.string :type
      t.date :date
      t.references :user

      t.timestamps
    end
  end
end
