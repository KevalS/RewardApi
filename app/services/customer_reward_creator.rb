class CustomerRewardCreator
    def initialize(customer, reward_name)
        @customer = customer
        @transaction = @customer.transactions.last
        @reward_name = reward_name
    end

    def self.call(*args)
        new(*args).create_reward
    end

    def create_reward
        @customer_reward = CustomerReward.create({
                                reward: Reward.find_by_name(@reward_name),
                                customer: @customer,
                                transaction_id: @transaction.id
                            })
    end
end