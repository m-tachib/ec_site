class Cart < ApplicationRecord
    # 関連付け（カートと商品）
    has_many :line_items  # カートは複数のカートアイテムと関連（１対多）
    has_many :products, through: :line_items  # 中間テーブルを通じて複数の商品と関連（多対多）

    # 商品をカートに追加
    # すでにカートにある場合は数量を1増やし、新規の場合はListItemオブジェクトを作成
    def add_book(book, quantity)
        line_item = line_items.find_or_initialize_by(book: book)
        line_item.quantity ||= 0
        line_item.quantity += quantity
        line_item.price = line_item.quantity * book.price
        line_item
    end

    # カート内の合計金額を計算
    def total_price
        line_items.to_a.sum { |item| item.total_price }
    end

    # カート内の合計個数を計算
    def total_quantity
        line_items.to_a.sum { |item| item.quantity }
    end
end
