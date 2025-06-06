class Order < ApplicationRecord
    validates :quantity, presence: true
    # validates :total, presence: true
    validates :delivery_address, presence: true
end
