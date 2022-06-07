class Product < ApplicationRecord
    belongs_to :category
    belongs_to :user
    has_many :comments, dependent: :destroy
    has_one_attached :image

    validates :title, presence: true
    validates :description, presence: true
    validates :price, presence: true

    scope :filter_by_category, -> (category_id) {where category_id: category_id if category_id.present? }


end
