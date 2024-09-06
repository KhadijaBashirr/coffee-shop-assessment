module Api
  module V1
    class OrdersController < ApplicationController
      before_action :authenticate_user!

      def create
        @order = current_user.orders.build(order_params)
        if @order.save
          OrderProcessingJob.set(wait: 5.minutes).perform_later(@order.id)
          render json: @order, status: :created
        else
          render json: @order.errors, status: :unprocessable_entity
        end
      end

      def show
        @order = current_user.orders.find(params[:id])
        render json: @order, include: { order_items: { include: :item } }
      end

      def update
        @order = current_user.orders.find(params[:id])
        if @order.update(order_params)
          render json: @order
        else
          render json: @order.errors, status: :unprocessable_entity
        end
      end

      private

      def order_params
        params.require(:order).permit(order_items_attributes: [:item_id, :quantity])
      end
    end
  end
end