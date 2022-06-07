class Reward < ApplicationRecord
  has_many :customer_rewards

  validates_presence_of :name, :description
end
