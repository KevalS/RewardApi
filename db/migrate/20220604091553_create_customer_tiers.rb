class CreateCustomerTiers < ActiveRecord::Migration[7.0]
  def change
    create_table :customer_tiers do |t|
      t.references :customer, null: false, foreign_key: true
      t.references :tier, null: false, foreign_key: true

      t.timestamps
    end
  end
end
