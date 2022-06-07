class CustomerReward < ApplicationRecord
  belongs_to :reward
  belongs_to :customer

  scope :rebate_reward, -> {joins(:reward).where('rewards.name = ?', "Cash Rebate Reward").where('extract(year from customer_rewards.created_at) = ?', Date.today.year)}
  scope :coffee_reward, -> {joins(:reward).where('rewards.name = ?', "Monthly Reward").where('extract(month from customer_rewards.created_at) = ?', Date.today.month)}
  scope :birthday_reward, -> {joins(:reward).where('rewards.name = ?', "Birthday Reward").where('extract(month from customer_rewards.created_at) = ?', Date.today.month)}
  scope :movie_reward, -> {joins(:reward).where('rewards.name = ?', "Movie Reward")}
  scope :airport_reward, -> {joins(:reward).where('rewards.name = ?', "Airport Reward")}
  scope :quarterly_reward, ->{joins(:reward).where('rewards.name =?', "Quarterly Reward").where("customer_rewards.created_at >= ? AND customer_rewards.created_at <= ?", Date.today.beginning_of_quarter, Date.today.end_of_quarter)}
end
