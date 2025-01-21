class Order < ApplicationRecord
    belongs_to :user
    has_many :order_items, dependent: :destroy
    has_many :dishes, through: :order_items
end
