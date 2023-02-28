class Api::V1::OrdersController < ApplicationController
    before_action :check_login, only: %i[index show create]

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

    def create 
        @order = current_user.orders.build(order_params)
        if @order.save 
            render json: @order, status: 201
        else
            render json: @order.errors, status: 422
        end
    end

    private 

    def order_params 
        params.require(:order).permit(:total, product_ids: [])
    end
end
