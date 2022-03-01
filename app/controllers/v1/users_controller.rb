module V1
  class UsersController < ApplicationController
    include Pagy::Backend

    def index
      users_number = User.count
      items_per_page = 50
      page = rand(1..(users_number/items_per_page))

      relation = User.includes(:account, :location, :orders, :order_items)

      pagy, users = pagy(relation, page: page, items: items_per_page)

      render json: users,
             each_serializer: UserSerializer
    end
  end
end
