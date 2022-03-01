class UserSerializer < ActiveModel::Serializer
  attributes :id,
             :first_name,
             :last_name,
             :phone,
             :address,
             :books_read

  belongs_to :account

  def address
    object.location
          .attributes
          .slice('zip_code', 'city', 'street', 'building_number', 'appartment_number')
          .values
          .join(', ')
  end

  def books_read
    object.order_items.size
  end
end
