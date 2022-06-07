class Tier < ApplicationRecord
    has_many :customer_tiers

    validates_presence_of :name, :priority
end
