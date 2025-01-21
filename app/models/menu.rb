class Menu < ApplicationRecord
    has_many :dishes, dependent: :destroy
end
