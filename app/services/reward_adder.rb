class RewardAdder
    def initialize(customer)
        @customer = customer
        @customer_rewards = @customer.customer_rewards
        @customer_transactions = @customer.transactions
    end

    def self.call(*args)
        new(*args).apply_rewards
    end

    def apply_rewards
        if @customer_rewards.rebate_reward.blank?
            if @customer_transactions.greater_than_hundred >= 10
                CustomerRewardCreator.call(@customer, "Cash Rebate Reward")
            end
        end

        if @customer.customer_rewards.coffee_reward.blank?
            if @customer.loyalty_points.greater_than_hundred > 100
                CustomerRewardCreator.call(@customer, "Monthly Reward")
            end
        end

        if @customer_rewards.movie_reward.blank?
            if @customer_transactions.first_60_days(@customer_transactions.first.created_at) > 1000
                CustomerRewardCreator.call(@customer, "Movie Reward")
            end
        end

        if @customer_rewards.airport_reward.blank?
            if @customer.current_tier == "Gold"
                CustomerRewardCreator.call(@customer, "Airport Reward")
            end
        end

        if @customer_rewards.birthday_reward.blank?
            if @customer.dob.month == Date.today.month
                CustomerRewardCreator.call(@customer, "Birthday Reward")
            end
        end

        if @customer_rewards.quarterly_reward.blank?
            if @customer_transactions.quarterly_transaction > 2000
                CustomerRewardCreator.call(@customer, "Quarterly Reward")
            end
        end
    end

end