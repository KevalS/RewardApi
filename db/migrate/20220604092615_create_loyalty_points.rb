class CreateLoyaltyPoints < ActiveRecord::Migration[7.0]
  def change
    create_table :loyalty_points do |t|
      t.integer :points
      t.references :customer, null: false, foreign_key: true
      t.references :transaction, null: false, foreign_key: true

      t.timestamps
    end
  end
end
