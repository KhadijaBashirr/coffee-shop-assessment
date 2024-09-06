module Api
  module V1
    class OrdersController < ApplicationController
      before_action :find_or_create_customer, only: :place_order

      def add_item
        @order_item = OrderItem.find_or_create_by(add_item_params)

        if @order_item.save
          render json: { message: "Item has been added!", data: { order_item: @order_item } }, status: 200
        else
          render json: @order_item.errors, status: :unprocessable_entity
        end
      end

      def place_order
        if order.update(customer_id: @customer.id, status: :placed)
          render json: { message: 'order has been placed!', order:}, status: 200
        else
          render json: { message: 'unable to place order!'}, status: :unprocessable_entity
        end
      end

      def show
        @order = Order.find(params[:id])

        if @order
          render json: order, serializer: OrderSerializer, status: 200
        else
          render json: { message: 'order not found!'}, status: 404
        end
      end

      private

      def order
        @order ||= Order.find_or_create_by(id: params[:id])
      end

      def add_item_params
        params.permit(:item_id, :quantity).with_defaults(order_id: order.id)
      end

      def find_or_create_customer
        @customer = if params[:customer_id]
                      Customer.find(params[:customer_id])
                    else
                      Customer.create(customer_params)
                    end
      end

      def customer_params
        params.require(:customer).permit(:email, :phone_number, :name)
      end
    end
  end
end
