require_relative '../../app/services/tier_applier.rb'
require 'rails_helper'

RSpec.describe TierApplier do
	describe "Tier appler service" do
		fixtures :tier
		context "when create a new customer tier" do
			let!(:customer) { create(:customer) } #now the customer has one standerd customer tier becouse of after create

			it "should apply standard tier for new customer" do
				described_class.call(customer).create_tire
				expect(customer.customer_tiers.count).to eq(2)
				expect(customer.customer_tiers.last.tier).to eq(tier(:standard_tier))
			end
		end

		context "when update customer tier" do
			let!(:customer) { create(:customer) } #now the customer has one standerd customer tier becouse of after create
			let!(:dummy_transation) {create(:transaction, customer: customer)}
			let!(:loyalty_point) {create(:loyalty_point, customer: customer, transaction_id: dummy_transation.id)}

			it "should apply gold tier for customer according to the loyalty point" do
				loyalty_point.update(points: 3000)
				expect(customer.customer_tiers.last.tier).to eq(tier(:standard_tier))

				described_class.call(customer).update_tier
				expect(customer.customer_tiers.count).to eq(1)
				expect(customer.customer_tiers.last.tier).to eq(tier(:gold_tier))
			end

			it "should apply platinum tier for customer according to the loyalty point" do
				loyalty_point.update(points: 5000)
				expect(customer.customer_tiers.last.tier).to eq(tier(:standard_tier))

				described_class.call(customer).update_tier
				expect(customer.customer_tiers.count).to eq(1)
				expect(customer.customer_tiers.last.tier).to eq(tier(:platinum_tier))
			end
		end
	end
end