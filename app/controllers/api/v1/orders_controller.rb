class Api::V1::OrdersController < ApplicationController
    before_action :check_login, only: %i[index]

    def index 
        @orders = OrderSerializer.new(current_user.orders
        ).serializable_hash
        render json: @orders, status: 200
    end
end
