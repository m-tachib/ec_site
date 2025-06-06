class OrdersController < ApplicationController
  def new
    @order = Order.new
    @book = Book.find(params[:book_id])
  end
end
