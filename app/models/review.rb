class Review < ApplicationRecord
    belongs_to :user

    def self.ransackable_associations(auth_object = nil)
        ["user"]
    end

    def self.ransackable_attributes(auth_object = nil)
        ["comment", "created_at", "dish_id", "id", "id_value", "rating", "updated_at", "user_id"]
    end
    
end
