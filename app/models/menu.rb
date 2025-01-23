class Menu < ApplicationRecord
    has_many :dishes, dependent: :destroy

    def self.ransackable_attributes(auth_object = nil)
        [ "active", "category", "created_at", "description", "id", "special_notes", "title", "updated_at" ]
      end

    def self.ransackable_associations(auth_object = nil)
        [ "dishes" ]
    end
end
