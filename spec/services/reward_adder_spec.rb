require_relative '../../app/services/reward_adder.rb'
require 'rails_helper'

RSpec.describe RewardAdder do
	describe "to create customers rewards" do
    fixtures :reward
    let!(:customer) { create(:customer, dob:(Date.today-2.month)) }

		context "when reward name is passed in this class" do
      let!(:transaction) { create(:transaction, customer: customer, amount: 1100)}
			it "it should return sucess with monthly reward us customer reward" do
        described_class.call(customer)
        expect(customer.customer_rewards.count).to eq(2)
        expect(customer.customer_rewards.first.reward).to eq(reward(:monthly_reward))
        expect(customer.customer_rewards.last.reward).to eq(reward(:movie_reward))
			end
    end
    context "when reward name is passed in this class" do
      let!(:transactions) { create_list(:transaction, 10, customer: customer, amount: 101) }
      it "it should return sucess with birthday reward us customer reward" do
        described_class.call(customer)
        expect(customer.customer_rewards.count).to eq(2)
        expect(customer.customer_rewards.first.reward).to eq(reward(:cash_rebate_reward))
        expect(customer.customer_rewards.last.reward).to eq(reward(:movie_reward))
      end
    end
    context "when reward name is passed in this class" do
      let!(:transaction) { create(:transaction, customer: customer, amount: 1001) }
      it "it should return sucess with cash rebate reward us customer reward" do
        described_class.call(customer)
        expect(customer.customer_rewards.count).to eq(1)
        expect(customer.customer_rewards.last.reward).to eq(reward(:movie_reward))
      end
    end
    context "when reward name is passed in this class" do
      let!(:transaction) { create(:transaction, customer: customer) }
      let!(:loyality_point){create(:loyalty_point, customer: customer, transaction_id: transaction.id, points: 1000)}
      it "it should return sucess with airport reward us customer reward" do
        described_class.call(customer)
        expect(customer.customer_rewards.count).to eq(2)
        expect(customer.customer_rewards.first.reward).to eq(reward(:monthly_reward))
        expect(customer.customer_rewards.last.reward).to eq(reward(:airport_reward))
      end
    end
	end
end