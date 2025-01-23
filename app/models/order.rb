class Order < ApplicationRecord
    belongs_to :user
    has_many :order_dishes, dependent: :destroy
    has_many :dishes, through: :order_dishes

    validates :delivery_date, presence: true
    validates :event_details, presence: true
    validates :group_size, presence: true
  
    def self.ransackable_associations(auth_object = nil)
        [ "dishes", "order_dishes", "user" ]
    end

    def self.ransackable_attributes(auth_object = nil)
        [ "created_at", "delivery_date", "event_details", "group_size", "id", "status", "total_cost", "updated_at", "user_id" ]
    end

    before_save :set_creation_status # Sets the status of the order automatically to pending when user submits


    private

    def set_creation_status
        self.status ||= "Order Creation"
    end
end
