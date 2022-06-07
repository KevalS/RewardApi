class Api::V1::TransactionsController < ApplicationController
  before_action :authenticate_client!
  before_action :set_customer
  def create
    customer_transaction = @current_customer.transactions.create(transaction_params)
    gained_points = customer_transaction.loyalty_points.last.try(:points)
    reward = customer_transaction.rewards
    render json: { tier: @current_customer.current_tier, points: gained_points, rewards: ActiveModelSerializers::SerializableResource.new(reward, each_serializer: RewardSerializer) }
  end

  private

  def set_customer
    @current_customer = current_client.customers.find_by_email(customer_email)
    render json: { error_message: 'customer not found' } if @current_customer.blank?
  end

  def customer_email
    params[:transaction][:email]
  end


  def transaction_params
    params.require(:transaction).permit(:amount, :description, :country, :currency)
  end
end
