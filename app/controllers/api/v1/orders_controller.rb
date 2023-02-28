class Api::V1::OrdersController < ApplicationController
    before_action :check_login, only: %i[index show]

    def index 
        @orders = OrderSerializer.new(current_user.orders
        ).serializable_hash
        render json: @orders, status: 200
    end
    
    def show 
        @order = current_user.orders.find(params[:id])
        if @order
            options = {include: [:products]}
            @order = OrderSerializer.new(@order, options
            ).serializable_hash
            render json: @order, status: 200
        else
            head 402
        end
    end
end
