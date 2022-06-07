class CustomerTier < ApplicationRecord
  belongs_to :customer
  belongs_to :tier
end
