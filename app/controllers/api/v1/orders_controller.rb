module Api
  module V1
    class OrdersController < ApplicationController
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

      def show
        @order = Order.find(params[:id])
        render json: @order
      end

      private

      def order_params
        params.require(:order).permit(:customer_id, order_items_attributes: %i[item_id quantity])
      end

      def calculate_total
        total = @order.order_items.sum do |item|
          subtotal = item.item.price * item.quantity
          tax = subtotal * (item.item.tax_bucket.tax_percentage / 100)
          discount = calculate_discount(item)
          subtotal + tax - discount
        end
        @order.update(total:)
      end

      def calculate_discount(order_item)
        discount = Discount.find_by(item: order_item.item)
        if discount && @order.order_items.exists?(item: discount.required_item)
          order_item.item.price * order_item.quantity * (discount.percentage / 100)
        else
          0
        end
      end
    end
  end
end
