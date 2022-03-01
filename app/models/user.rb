class User < ApplicationRecord
  belongs_to :account

  has_one :location, as: :addressable, dependent: :destroy

  has_many :orders, dependent: :destroy
  has_many :order_items, through: :orders
end
