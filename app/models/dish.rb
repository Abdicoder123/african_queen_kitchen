class Dish < ApplicationRecord
    belongs_to :menu
    has_many :order_dishes, dependent: :destroy
    has_many :orders, through: :order_dishes

    def self.ransackable_attributes(auth_object = nil)
        [ "created_at", "customizable", "description", "id", "image_url", "menu_id", "price", "title", "updated_at" ]
    end
    def self.ransackable_associations(auth_object = nil)
        [ "menu", "order_dishes", "orders" ]
      end
end
