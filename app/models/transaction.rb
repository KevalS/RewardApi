class Transaction < ApplicationRecord
  belongs_to :customer
  has_many :loyalty_points
  has_many :customer_rewards
  has_many :rewards , through: :customer_rewards

  validates_presence_of :amount, :description, :country, :currency

  scope :greater_than_hundred, -> {where("amount > ?", 100).where('extract(year from created_at) = ?', Time.now.year).count} 
  scope :first_60_days, lambda {|start_date| where("created_at >= ? AND created_at <= ?", start_date, start_date+60.days).sum(:amount)}
  scope :quarterly_transaction, -> {where("created_at >= ? AND created_at <= ?", Date.today.beginning_of_quarter, Date.today.end_of_quarter).sum(:amount)}

  after_create :create_loyalty_point

  def create_loyalty_point
    customer_point = LoyaltyPointAdder.call(self)
  end
end
