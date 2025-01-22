class Order < ApplicationRecord
    belongs_to :user
    has_many :order_dishes, dependent: :destroy
    has_many :dishes, through: :order_dishes


    before_save :set_pending_status


    private

    def set_pending_status
        self.status ||= "Pending"
    end
end
