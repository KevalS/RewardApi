class Customer < ApplicationRecord

  belongs_to :client
  has_many :customer_rewards, dependent: :destroy
  has_many :transactions
  has_many :loyalty_points, dependent: :destroy
  has_many :customer_tiers, dependent: :destroy
  has_many :rewards, through: :customer_rewards
  has_many :tiers, through: :customer_tiers

  validates_presence_of :email, :name, :dob
  validates :email, format: { with: Devise.email_regexp }
  validates_uniqueness_of :email, scope: :client_id

  after_create :customer_tier_create

  def customer_tier_create
    TierApplier.call(self).create_tire
  end

  def customer_tier
    customer_tier = Tier.where(ids: self.customer_tiers.last(3).pluck(:id)).order(:priority).last
    return customer_tier.name
  end

  def current_tier
    self&.customer_tiers.last.tier&.name
  end

  def acquired_loyalty_points(year)
    self.loyalty_points.where('extract(year from created_at) = ?', year).sum('points')
  end
end
