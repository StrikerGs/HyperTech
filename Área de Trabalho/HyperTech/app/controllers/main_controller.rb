class MainController < ApplicationController
  include Paginable

  def index
    
    @products = Product.includes([image_attachment: :blob]).order(created_at: :desc).page(current_page).per(4)
  end
end
