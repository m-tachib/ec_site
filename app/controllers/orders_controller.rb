class OrdersController < ApplicationController
  # 注文画面
  def new
    @order = Order.new
    @line_items = current_cart.line_items
  end

  # 注文内容の確認画面
  def confirm
    # 注文内容とカート内の商品を取得
    @order = Order.new(order_params)   #フォームから送信された注文情報を取得
    @line_items = current_cart.line_items
    @cart = current_cart

    # バリデーションチェック（住所が空の場合）
    if order_params[:delivery_address].blank?
      # 入力フォームに戻すためにリダイレクト
      redirect_to new_order_path and return
    end

    # カート内の商品を確認・更新
    @line_items.each do |line_item|
      quantity = params[:order]["line_item_quantity_#{line_item.id}"].to_i

      # 数量が0の場合は削除、それ以外は更新
      if quantity > 0
        line_item.update(quantity: quantity)
              # 注文詳細に追加
        build_order_details(line_item)
      else
        line_item.destroy
      end


    end

    # 注文詳細を仮にセット（確認画面用）
    @order_details = set_order_details

    # 合計金額や数量を計算
    @order.total = cal_total_price
    @order.quantity = cal_count
    if @order.quantity <= 0
      redirect_to books_path, notice: "商品が買い物かごに入っていません"
    end
  end

  # 注文登録
  def create
    @order = Order.new(order_params)
    # カート内の商品を注文詳細として登録
    current_cart.line_items.each do |line_item|
      build_order_details(line_item)
    end

    # 注文が正常に保存できた場合
    if @order.save
      current_cart.line_items.destroy_all  #注文後にカートを空にする
      redirect_to complete_order_path(@order)  #登録が完了したら注文完了ページへ遷移
    else
      render "new", status: :unprocessable_entity  #注文入力へ戻る
    end
  end

  # 注文完了
  def complete
    @order = Order.find(params[:id])
    @order_details = set_order_details  #注文詳細を格納
  end


  private


  # 許可する注文パラメータの設定（ストロングパラメータ）
  def order_params
    params.require(:order).permit(:total, :delivery_address, :quantity)
  end

  # 合計金額を計算
  def cal_total_price
    @order_details.sum{ |item| item[:price] }
  end

  # 合計個数の計算
  def cal_count
    @order_details.sum { |item| item[:count] }
  end

  # 変数に注文詳細データの格納
  def set_order_details
    @order.order_details.map do |detail|
      {
        name: detail.book.book_name,
        count: detail.count,
        price: detail.price
      }
    end
  end

  # 注文詳細の作成
  def build_order_details(line_item)
    @order.order_details.build(
      book: line_item.book,
      count: line_item.quantity,
      price: line_item.price * line_item.quantity
    )
  end
end
