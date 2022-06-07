class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.float :amount
      t.string :description
      t.string :country
      t.string :currency
      t.references :customer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
