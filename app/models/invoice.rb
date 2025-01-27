class Invoice < ApplicationRecord
    belongs_to :user
    belongs_to :order

    def self.ransackable_attributes(auth_object = nil)
        [ "created_at", "total_amount", "description", "id", "stripe_invoice_id", "currency", "invoice_status", "stripe_checkout_session_id" ]
    end
    def self.ransackable_associations(auth_object = nil)
        [ "user", "order" ]
      end
end
