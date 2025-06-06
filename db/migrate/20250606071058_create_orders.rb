class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.integer :quantity
      t.integer :total
      t.string :delivery_address

      t.timestamps
    end
  end
end
