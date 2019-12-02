class AddZipcodeAndCityToFlats < ActiveRecord::Migration[5.2]
  def change
    add_column :flats, :zipcode, :integer
    add_column :flats, :city, :string
  end
end
