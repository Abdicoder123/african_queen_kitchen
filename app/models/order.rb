class Order < ApplicationRecord
    belongs_to :user
    has_many :order_dishes, dependent: :destroy
    has_many :dishes, through: :order_dishes

    def self.ransackable_associations(auth_object = nil)
        [ "dishes", "order_dishes", "user" ]
    end

    def self.ransackable_attributes(auth_object = nil)
        [ "created_at", "delivery_date", "event_details", "group_size", "id", "status", "total_cost", "updated_at", "user_id" ]
    end
end
