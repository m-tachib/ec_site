class AddBookIdToOrders < ActiveRecord::Migration[7.1]
  def change
    add_column :orders, :book_id, :integer
  end
end
