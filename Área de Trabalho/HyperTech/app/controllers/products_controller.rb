class ProductsController < ApplicationController
  include Paginable
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_product, only: %i[ edit update destroy ]



  def add_to_cart
    id = params[:id].to_i
    session[:cart] << id unless session[:cart].include?(id)
    redirect_to product_url
  end

  def remove_from_cart
    id = params[:id].to_i
    session[:cart].delete(id)
    redirect_to product_url
  end

  # GET /products or /products.json
  def index
    
    @products = Product.includes([image_attachment: :blob], [:user], [:category]).filter_by_category(params[:category_id]).order(created_at: :desc).page(current_page).per(8)

    @categories = Category.all
    authorize @products
  end

  # GET /products/myproduct
  def myprod

    @products = Product.includes([image_attachment: :blob], [:user]).filter_by_category(params[:category_id]).order(created_at: :desc).page(current_page).per(8)
    authorize @products

  end

  # GET /products/1 or /products/1.json
  def show

    @product = Product.includes([comments: :user]).find(params[:id])
    authorize @product

  end

  # GET /products/new
  def new
    @product = current_user.products.new
    authorize @product
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products or /products.json
  def create
    @product = current_user.products.new(product_params)
    authorize @product

    respond_to do |format|
      if @product.save
        format.html { redirect_to product_url(@product), notice: "Produto foi criado com sucesso" }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1 or /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to product_url(@product), notice: "Produto foi editado com sucesso." }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1 or /products/1.json
  def destroy
    @product.destroy

    respond_to do |format|
      format.html { redirect_to products_url, notice: "Produto foi excluido com sucesso." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
      authorize @product
    end

    # Only allow a list of trusted parameters through.
    def product_params
      params.require(:product).permit(:title, :description, :price,:price_cents, :image, :category_id, :currency)
    end
end
