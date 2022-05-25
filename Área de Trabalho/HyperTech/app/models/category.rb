class Category < ApplicationRecord
    has_many :products, dependent: :restrict_with_error

    validates :c_name, presence: true
end
