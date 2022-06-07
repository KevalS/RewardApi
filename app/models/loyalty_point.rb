class LoyaltyPoint < ApplicationRecord
  belongs_to :customer
  belongs_to :point_transaction, class_name: "Transaction", foreign_key: "transaction_id"

  validates_presence_of :points

  scope :greater_than_hundred, -> {where('extract(month from created_at) = ?', Time.now.month).sum('points')}

  after_create :update_customer_tier

  def update_customer_tier
    if self.created_at.year == self.customer.customer_tiers.last.updated_at.year
        TierApplier.call(self.customer).update_tier
    else
        TierApplier.call(self.customer).create_tier
    end
    RewardAdder.call(self.customer)
  end
end
