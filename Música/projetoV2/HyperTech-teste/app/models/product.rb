class Product < ApplicationRecord
    belongs_to :category
    belongs_to :user
    has_one_attached :image

    validates :title, presence: true
    validates :description, presence: true
    validates :price, presence: true


end
