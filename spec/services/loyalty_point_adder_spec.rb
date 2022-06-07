require_relative '../../app/services/loyalty_point_adder.rb'
require 'rails_helper'

RSpec.describe LoyaltyPointAdder do
	describe "Loyalty point calculation" do
		let!(:customer) { create(:customer) }
		context "when transaction amount 100$" do
			let!(:transaction) { create(:transaction, customer: customer, amount:100, currency: "USD" )}
			it "should return 10 loyalty points" do
				described_class.call(transaction)
				expect(customer.loyalty_points.last.points).to eq(10)
			end
		end

		context "when transaction amount is less than 100$" do
			let!(:transaction) { create(:transaction, customer: customer, amount:50 )}
			it "should not create loyalty points" do
				described_class.call(transaction)
				expect(customer.loyalty_points.count).to eq(0)
			end
		end

		context "when forgin transaction" do
			let!(:transaction) { create(:transaction, customer: customer, amount:100, currency: "IND" )}
			it "should return 2x loyalty points " do
				described_class.call(transaction)
				expect(customer.loyalty_points.last.points).to eq(20)
			end
		end

		context "when total transaction amount is above 2000$ in quaterly" do
			let!(:previous_transactions) { create_list(:transaction, 4, customer:customer, amount: 500, currency: "USD") }
			let!(:transaction) { create(:transaction, customer: customer, amount: 1, currency: "USD" )}
			it "should add 100 loyalty points" do
				described_class.call(transaction)
				expect(customer.loyalty_points.last.points).to eq(100)
			end
		end
	end
end