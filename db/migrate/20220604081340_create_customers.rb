class CreateCustomers < ActiveRecord::Migration[7.0]
  def change
    create_table :customers do |t|
      t.references :client, null: false, foreign_key: true
      t.string :name,   null: false
      t.string :email,  null: false
      t.date  :dob, null: false
      t.timestamps
    end
  end
end
