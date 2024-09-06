module Api
  module V1
    class ItemsController < ApplicationController
      def index
        @items = Item.includes(:category).all
        render json: @items, include: :category
      end

      def show
        @item = Item.find(params[:id])
        render json: @item, include: :category
      end
    end
  end
end