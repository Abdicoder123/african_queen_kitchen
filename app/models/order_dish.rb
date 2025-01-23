class OrderDish < ApplicationRecord
  belongs_to :dish
  belongs_to :order

  validates :quantity, presence: true, numericality: { greater_than: 0 }
  # validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }

  def self.ransackable_attributes(auth_object = nil)
    [ "created_at", "dish_id", "id", "order_id", "price", "quantity", "updated_at" ]
  end
end
