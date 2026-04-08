module Api
  module V1
    class ItemsController < ApplicationController
      def index
        items = Item.all
        render json: items
      end

      def create
        item = Item.new(item_params)
        if item.save
          render json: item, status: :created
        else
          render json: { errors: item.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def item_params
        params.require(:item).permit(:name, :description)
      end
    end
  end
end
