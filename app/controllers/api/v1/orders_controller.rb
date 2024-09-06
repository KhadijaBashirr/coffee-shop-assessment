module Api
  module V1
    class OrdersController < ApplicationController
      before_action :create_or_get_order, only: :add_item

      def create
        @order = Order.new(order_params)
        if @order.save
          calculate_total
          OrderCompletionJob.set(wait: 5.minutes).perform_later(@order.id)
          render json: @order, status: :created
        else
          render json: @order.errors, status: :unprocessable_entity
        end
      end

      def add_item
        
      end

      def show
        @order = Order.find(params[:id])
        render json: @order
      end

      private

      def create_or_get_order

      end

      def order_params
        params.require(:order).permit(:customer_id, order_items_attributes: %i[item_id quantity])
      end
    end
  end
end
