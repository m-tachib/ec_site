class OrdersController < ApplicationController
  # 注文画面
  def new
    @order = Order.new
    @book = Book.find(params[:book])
  end

  # 注文内容の確認画面
  def confirm
    @order = Order.new(order_params)   #フォームから送信された注文情報を取得
    @book = Book.find(order_params[:book_id])  #注文対象の商品を取得

    # # バリデーションチェック
    # if order_params[:delivery_address].blank?
    #   # 入力フォームに戻すためにリダイレクト
    #   redirect_to new_order_path and return
    # end
    if @order.valid?

      # 個数が未入力(nil)の場合は処理をスキップ
      unless @order.quantity.nil?
        @order.total = cal_total_price(@book.price, @order.quantity)  #合計金額を計算
      end
    else
      render "new", status: :unprocessable_entity
    end
  end

  # 注文登録
  def create
    @order = Order.new(order_params)
    # book_id = params[:order][:book_id]

    # 注文が正常に保存できた場合
    if @order.save
      redirect_to complete_order_path(@order)  #登録が完了したら注文完了ページへ遷移
    else
      @book = Book.find(order_params[:book_id])
      render "new", status: :unprocessable_entity  #注文入力へ戻る
    end
  end

  # 注文完了
  def complete
    @order = Order.find(params[:id])
    #  book_id = params[:book_id] || @order.book_id
    @book = Book.find(@order.book_id)
  end


  private


  # 許可する注文パラメータの設定（ストロングパラメータ）
  def order_params
    params.require(:order).permit(:total, :delivery_address, :quantity, :book_id)
  end

  # 合計金額を計算
  def cal_total_price(price, quantity)
    return price * quantity  #商品価格と個数をかけて合計金額を返す
  end
end
