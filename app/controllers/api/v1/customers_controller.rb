class Api::V1::CustomersController < ApplicationController
  before_action :authenticate_client!
  def create
    customer = current_client.customers.new(customer_params)
    if customer.save
      render json: customer
    else
      render json: { error: { message: customer.errors.full_messages } } , status: :unprocessable_entity
    end
  end

  private

  def customer_params
    params.require(:customer).permit(:name, :dob, :email)
  end
end