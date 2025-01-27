class Dish < ApplicationRecord
    belongs_to :menu
    belongs_to :admin_user

    has_many :order_dishes, dependent: :destroy
    has_many :orders, through: :order_dishes
    has_many_attached :images
    # Change from has_many_attached to has_one_attached for a single image
    has_one_attached :image

    # Define ransackable attributes
    def self.ransackable_attributes(auth_object = nil)
      [
        "created_at",
        "customizable",
        "description",
        "id",
        "image_url", # Ensure this attribute is supported or remove it
        "menu_id",
        "price",
        "title",
        "updated_at"
      ]
    end

    # Define ransackable associations
    def self.ransackable_associations(auth_object = nil)
      [
        "menu",
        "order_dishes",
        "orders"
      ]
    end
end
