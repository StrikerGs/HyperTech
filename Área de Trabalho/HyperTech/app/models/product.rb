class Product < ApplicationRecord
  
    belongs_to :category
    belongs_to :user
    has_many :comments, dependent: :destroy
    has_one_attached :image

    validates :title, presence: true
    validates :description, presence: true
    validates :price, presence: true

    scope :filter_by_category, -> (category_id) {where category_id: category_id if category_id.present? }

    def to_s
        title
    end

    monetize :price, as: :price_cents

    def to_builder
        Jbuilder.new do |product|
          product.price stripe_price_id
          product.quantity 1
        end
    end
    
    after_create do
        product = Stripe::Product.create(name: title)
        price = Stripe::Price.create(product: product, unit_amount: self.price, currency: self.currency )
        self.update_attribute(:stripe_product_id, product.id)
        self.update_attribute(:stripe_price_id, price.id)

      end
    
    after_update :create_and_assign_new_stripe_price, if: :saved_change_to_price?
    def create_and_assign_new_stripe_price 
      price = Stripe::Price.create(product: self.stripe_product_id, unit_amount: self.price, currency: self.currency )
      update(stripe_price_id: price.id)

    end

end
