class CartsController < ApplicationController
before_action :current_cart

  # カートの内容を表示する
  def show
    # カートに関連するアイテムを取得
    @line_items = current_cart.line_items
  end

  # カートを空にする処理
  def destroy
    # セッションのcart_idを削除
    session[:cart_id] = nil

    # 商品一覧ページへリダイレクト
    redirect_to books_path
  end
end
