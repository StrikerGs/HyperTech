class Category < ApplicationRecord
    has_many :products

    validates :c_name, presence: true
end
