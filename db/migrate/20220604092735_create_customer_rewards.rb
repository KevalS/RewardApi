class CreateCustomerRewards < ActiveRecord::Migration[7.0]
  def change
    create_table :customer_rewards do |t|
      t.references :reward, null: false, foreign_key: true
      t.references :customer, null: false, foreign_key: true
      t.references :transaction, null: false, foreign_key: true

      t.timestamps
    end
  end
end
