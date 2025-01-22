class Order < ApplicationRecord
    belongs_to :user
    has_many :order_dishes, dependent: :destroy
    has_many :dishes, through: :order_dishes

    validates :delivery_date, presence: true
    validates :event_details, presence: true
    validates :group_size, presence: true

    before_save :set_creation_status #Sets the status of the order automatically to pending when user submits


    private

    def set_creation_status
        self.status ||= "Order Creation"
    end
end
