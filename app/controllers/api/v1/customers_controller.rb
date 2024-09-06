module Api
  module V1
    class CustomersController < ApplicationController
      def populate_with_email
        @customer = Customer.find_by(email: params[:email])

        if @customer
          render json: @customer, status: 200
        else
          render json: { message: "customer not found!"}, status: 404
        end
      end

      private

      def customer_params
        params.require(:customer).permit(:name, :email, :phone_number)
      end
    end
  end
end
