class AddAddresableToLocations < ActiveRecord::Migration[6.1]
  def change
    add_reference :locations, :addressable, polymorphic: true
  end
end
