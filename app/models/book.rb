class Book < ApplicationRecord
    validates :book_name, presence: true
    validates :author_name, presence: true
    validates :price, presence: true

    # Enum （販売状況）
    enum status: { on_sale: 0, sold_out: 1 }

    # 関連付け（カート）
    has_many :line_items, dependent: :destroy  #商品は複数のカートアイテムと関連（1対多）
    has_many :carts, through: :line_items  #中間テーブルを通じて複数のカートと関連（多対多）

    # 関連付け（注文）
    has_many :order_details  #商品は複数の注文と関連（1対多）
    has_many :orders, through: :order_details  #中間テーブルを通じて複数の注文と関連（多対多）

    # 関連付け（タグ）
    has_many :taggings
    has_many :tags, through: :taggings

    # Active Storage（書籍画像）
    has_one_attached :photo

     accepts_nested_attributes_for :tags

    # 書籍画像のサムネイルを作成
    def thumbnail
        unless photo.attached?
            file_path = Rails.root.join('app/assets/images/no_image_logo.png')
            photo.attach(io: File.open(file_path), filename:'default-image.jpg', content_type: 'image/jpeg')
        end
        photo.variant(resize_to_limit: [150, 150]).processed
    end

    # 検索(Ransack)
    def self.ransackable_attributes(auto_object = nil)
        %w[book_name author_name issue_date price]
    end


end
