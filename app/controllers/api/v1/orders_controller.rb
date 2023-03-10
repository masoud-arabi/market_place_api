class Api::V1::OrdersController < ApplicationController
    include Paginable
    before_action :check_login, only: %i[index show create]

    def index 
        @orders = current_user.orders.page(current_page).per(per_page)
        options = get_links_serialaizer_optiins('api_v1_orders_path', @orders)
        @orders = OrderSerializer.new(@orders, options).serializable_hash
        render json: @orders, status: 200
    end
    
    def show 
        @order = current_user.orders.find(params[:id])
        @order.set_total!
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
        @order = Order.create!(user: current_user)
        @order.build_placements_with_product_ids_and_quantities(order_params[:product_ids_and_quantities])
        if @order.save
            OrderMailer.send_confirmation(@order).deliver 
            render json: @order, status: 201
        else
            render json: @order.errors, status: 422
        end
    end

    private 

    def order_params 
        params.require(:order).permit(:total, product_ids_and_quantities:[:product_id, :quantity])
    end
end
