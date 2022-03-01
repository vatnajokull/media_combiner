class Order < ApplicationRecord
  enum status: { open: 0, closed: 1 }

  belongs_to :user

  has_many :order_items, dependent: :destroy
  has_many :books, through: :order_items
end
