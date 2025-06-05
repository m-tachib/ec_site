class Book < ApplicationRecord
    validates :book_name, presence: true
    validates :author_name, presence: true
    validates :price, presence: true
    validates :status, presence: true

    enum status: { on_sale: 0, sold_out: 1}
end
