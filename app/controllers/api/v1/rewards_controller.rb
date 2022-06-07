class Api::V1::RewardsController < ApplicationController
  before_action :authenticate_client!
  before_action :set_customer
  def index
    reward = @current_customer.rewards
    render json: reward
  end

  private

  def set_customer
    @current_customer = current_client.customers.find_by_email(customer_email)
    render json: { error_message: 'customer not found' } if @current_customer.blank?
  end


  def customer_email
    params.require(:email)
  end
end
