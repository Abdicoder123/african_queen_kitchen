class Dish < ApplicationRecord
    belongs_to :menu
    has_many :order_dishes, dependent: :destroy
    has_many :orders, through: :order_dishes
end
