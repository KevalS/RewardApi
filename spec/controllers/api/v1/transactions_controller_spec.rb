require 'rails_helper'

RSpec.describe Api::V1::TransactionsController, type: :controller do
  fixtures :all
  describe "return rewards, points, tier after transaction" do

    let!(:client) { create(:client) }
    let!(:customer) { create(:customer, client: client, dob: ((Date.today -10.years)-2.month)) }

    before do
      login_as(client)
    end

    let!(:params) do
      {
        transaction:{
          amount: 100,
          description: "first transaction",
          country: "US",
          currency: "USD",
          email: customer.email
        }
      }
    end
    context "should return 10 point in first transaction of 100$ in this year" do

      it "should return sucess response with tier, points, rewards" do
        post :create, params: params

        transaction_response = JSON.parse(response.body)
        expect(transaction_response["tier"]).to eq(tier(:standard_tier).name)
        expect(transaction_response["points"]).to eq(10)
        expect(transaction_response["rewards"]).to eq([])

      end
    end

    context "should return brithday reward for transaction in customer birthday month" do
      it "should return sucess response with tier, points, rewards" do
        customer.update(dob: (Date.today - 10.years))
        post :create, params: params

        transaction_response = JSON.parse(response.body)
        expect(transaction_response["tier"]).to eq(tier(:standard_tier).name)
        expect(transaction_response["points"]).to eq(10)
        expect(transaction_response["rewards"].count).to eq(1)
        expect(transaction_response["rewards"].first["id"]).to eq(reward(:birthday_reward).id)
      end
    end

    context "should return movie reward for transaction above 1000$" do
      it "should return sucess response with tier, points, rewards" do
        params[:transaction] = params[:transaction].merge(amount: 1010)
        post :create, params: params

        transaction_response = JSON.parse(response.body)
        expect(transaction_response["tier"]).to eq(tier(:standard_tier).name)
        expect(transaction_response["points"]).to eq(100)
        expect(transaction_response["rewards"].count).to eq(1)
        expect(transaction_response["rewards"].first["id"]).to eq(reward(:movie_reward).id)
      end
    end

    context "should return cash rebate reward and movie reward when 10 transactions above 100$" do
      let!(:previous_transactions) { create_list(:transaction, 9, customer: customer, amount: 110) }

      it "should return sucess response with tier, points, rewards" do
        params[:transaction] = params[:transaction].merge(amount: 110)
        post :create, params: params

        transaction_response = JSON.parse(response.body)
        expect(transaction_response["tier"]).to eq(tier(:standard_tier).name)
        expect(transaction_response["points"]).to eq(10)
        expect(transaction_response["rewards"].count).to eq(2)
        expect(transaction_response["rewards"].first["id"]).to eq(reward(:cash_rebate_reward).id)
        expect(transaction_response["rewards"].second["id"]).to eq(reward(:movie_reward).id)
      end
    end

    context "should change the customer tier to gold when loyalty point above 1000" do
      let!(:previous_transactions) { create_list(:transaction, 9, customer: customer, amount: 1000, currency: "USD") }

      it "should return sucess response with tier, points, rewards" do
        params[:transaction] = params[:transaction].merge(amount: 1001)
        post :create, params: params

        transaction_response = JSON.parse(response.body)
        expect(transaction_response["tier"]).to eq(tier(:gold_tier).name)
        expect(transaction_response["points"]).to eq(100)
        expect(transaction_response["rewards"].count).to eq(1)
        expect(transaction_response["rewards"].first["id"]).to eq(reward(:cash_rebate_reward).id)
      end
    end

    context "should change the customer tier to platinum when loyalty point above 5000" do
      let!(:previous_transactions) { create_list(:transaction, 9, customer: customer, amount: 5001, currency:"USD") }

      it "should return sucess response with tier, points, rewards" do
        params[:transaction] = params[:transaction].merge(amount: 5001)
        post :create, params: params

        transaction_response = JSON.parse(response.body)
        expect(transaction_response["tier"]).to eq(tier(:platinum_tier).name)
        expect(transaction_response["points"]).to eq(500)
        expect(transaction_response["rewards"].count).to eq(1)
        expect(transaction_response["rewards"].first["id"]).to eq(reward(:cash_rebate_reward).id)
      end
    end
  end
end