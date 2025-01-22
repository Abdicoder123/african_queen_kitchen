class Order < ApplicationRecord
    belongs_to :user
    has_many :order_dishes, dependent: :destroy
    has_many :dishes, through: :order_dishes
    accepts_nested_attributes_for :order_dishes, allow_destroy: true


    before_save :set_pending_status


    private

    def set_pending_status
        self.status ||= "Pending"
    end
end
