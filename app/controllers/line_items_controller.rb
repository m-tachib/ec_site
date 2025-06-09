class LineItemsController < ApplicationController
  def create
    # 現在のカートを取得
    cart = current_cart

    # 商品をデータベースから取得
    book = Book.find(params[:book_id])

    # 商品をカートに追加
    @line_item = cart.add_book(book)
    
    # レスポンスを返す
    respond_to do |format|
        if @line_item.save
            # 成功した場合、商品一覧ページへリダイレクト
            format.html { redirect_to books_path }
        else
        # エラーが発生した場合、商品ページにリダイレクト
            format.html { redirect_to book_path(book.id) }
        end
    end
  end
end
