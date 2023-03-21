class ProductsController < ApplicationController
  before_action :set_product, only: %i[ show edit update destroy ]
  before_action :authenticate_admin, except: %i[index show]

  def index
    @products = Product.order(created_at: :desc)
  end

  def show
  end

  def new
    @product = current_user.products.build
  end

  def edit
  end

  def create
    @product = current_user.products.build(product_params)

    if @product.save
      respond_to do |format|
        format.html {redirect_to products_path, notice: "Product added"}
        format.turbo_stream
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @product.bidding_status = 'active' if product_params[:bidding_expiration] && product_params[:bidding_expiration].to_datetime.future?
    if @product.update(product_params)
      respond_to do |format|
        format.html {redirect_to products_path, notice: "Product updated"}
        format.turbo_stream
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @product.destroy
    respond_to do |format|
      format.html {redirect_to products_path, notice: "Product deleted"}
      format.turbo_stream
    end
  end

  private

    def set_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:name, :description, :starting_bid_price, :bidding_expiration, :bidding_status)
    end

end
