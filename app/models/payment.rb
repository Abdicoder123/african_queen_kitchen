class Payment < ApplicationRecord
    belongs_to :order

    def self.ransackable_associations(auth_object = nil)
        [ "order"]
    end

    def self.ransackable_attributes(auth_object = nil)
        [ "payment_status", "id", "due_date", "payment_method" ]
    end
end
