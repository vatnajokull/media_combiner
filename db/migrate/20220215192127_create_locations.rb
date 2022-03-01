class CreateLocations < ActiveRecord::Migration[6.1]
  def change
    create_table :locations do |t|
      t.string :city
      t.string :street
      t.integer :building_number
      t.integer :appartment_number
      t.string :zip_code

      t.timestamps
    end
  end
end
