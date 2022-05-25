class MainController < ApplicationController
  def index
    current_page = (params[:page] || 1).to_i
    @products = Product.order(created_at: :desc).page(current_page).per(2)
  end
end
