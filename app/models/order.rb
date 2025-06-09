class Order < ApplicationRecord
    validates :quantity, presence: true
    validates :delivery_address, presence: true

    # 関連付け（注文と商品）
    has_many :order_details, dependent: :destroy  #注文が削除されると、関連する注文詳細も削除
    has_many :books, through: :order_details  #中間テーブルを通じて複数の商品と関連（多対多）
    
end
