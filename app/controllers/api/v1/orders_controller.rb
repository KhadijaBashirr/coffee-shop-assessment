module Api
  module V1
    class OrdersController < ApplicationController
      def add_item
        @order_item = OrderItem.find_or_create_by(add_item_params)

        if @order_item.save
          render json: { message: "Item has been added!", data: { order_item: @order_item } }, status: 200
        else
          render json: @order.errors, status: :unprocessable_entity
        end
      end

      def place_order
      end

      def show
        @order = Order.find(params[:id])
        render json: @order
      end

      private

      def order
        @order ||= order.find_or_create_by(id: params[:id])
      end

      def add_item_params
        params.permit(:item_id, :quantity).with_defaults(order_id: order)
      end
    end
  end
end
