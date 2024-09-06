module Api
  module V1
    class ItemsController < ApplicationController
      def index
        @items = Item.grouped_by_category
        render json: @items
      end

      def show
        @item = Item.find(params[:id])
        render json: @item
      end
    end
  end
end
