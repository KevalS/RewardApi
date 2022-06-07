class LoyaltyPointAdder
    def initialize(transaction)
        @transaction = transaction
        @customer = @transaction.customer
    end

    def self.call(*args)
        new(*args).add_redeem_point
    end

    def add_redeem_point
        points = calculate_redeem_points(@transaction.amount, @transaction.currency)
        LoyaltyPoint.create({
                points: points,
                customer: @customer,
                transaction_id: @transaction.id
                })  if points&.nonzero?
    end

    private

    def calculate_redeem_points(amount, currency)
        redeem_points = (amount/100).to_i * 10
        redeem_points *= 2 if "USD"!= currency
        redeem_points += 100 if (@customer.transactions.quarterly_transaction) > 2000 && @customer.customer_rewards.quarterly_reward.blank?
        return redeem_points
    end
end