require 'rails_helper'

RSpec.describe Api::V1::RewardsController, type: :controller do
	describe "Return rewards of a customer" do
		fixtures :all
		let!(:client){ create(:client) }
		let!(:customer) { create(:customer, client: client) }

		before do
			login_as(client)
		end

		let!(:params) do
			{	
				email: customer.email
			}
		end

		context "if customer is eligible for monthly reward" do
			let!(:transaction) { create(:transaction, customer: customer, amount: 1000)}
			let!(:customer_reward) { create(:customer_reward, customer: customer, transaction_id: transaction.id, reward: reward(:monthly_reward)) }
			it "should return success response with monthly reward" do
				get :index, :params => params

				rewards = JSON.parse(response.body)
				expect(rewards.first["id"]).to eq(reward(:monthly_reward).id)
				expect(rewards.first["name"]).to eq(reward(:monthly_reward).name)
			end
		end

		context "if customer is eligible for cash rebate reward" do
			let!(:transaction) { create(:transaction, customer: customer, amount: 1000, currency:"USD") }
			let!(:customer_reward) { create(:customer_reward, customer: customer, transaction_id: transaction.id, reward: reward(:cash_rebate_reward)) }
			it "should return success response cash rebate reward" do
				get :index, :params => params

				rewards = JSON.parse(response.body)
				expect(rewards.first["id"]).to eq(reward(:cash_rebate_reward).id)
				expect(rewards.first["name"]).to eq(reward(:cash_rebate_reward).name)
			end
		end

		context "if customer is eligible for movie reward" do
			let!(:transaction) { create(:transaction, customer: customer, amount: 1000, currency:"USD") }
			let!(:customer_reward) { create(:customer_reward, customer: customer, transaction_id: transaction.id, reward: reward(:movie_reward)) }
			it "should return success response with movie reward" do
				get :index, :params => params

				rewards = JSON.parse(response.body)
				expect(rewards.first["id"]).to eq(reward(:movie_reward).id)
				expect(rewards.first["name"]).to eq(reward(:movie_reward).name)
			end
		end

		context "if customer is eligible for airport reward" do
			let!(:transaction) { create(:transaction, customer: customer, amount: 1000, currency:"USD") }
			let!(:customer_reward) { create(:customer_reward, customer: customer, transaction_id: transaction.id, reward: reward(:airport_reward)) }
			it "should return success response with airport reward" do
				get :index, :params => params

				rewards = JSON.parse(response.body)
				expect(rewards.first["id"]).to eq(reward(:airport_reward).id)
				expect(rewards.first["name"]).to eq(reward(:airport_reward).name)
			end
		end
	end
end