class BidsController < ApplicationController
  before_action :set_bid, only: %i[ edit update ]
  before_action :set_product, only: %i[new create edit update]
  before_action :authenticate_admin, only: %i[ index ]
  before_action :restrict_admin, only: %i[new create edit update]

  def index
    @bids = Bid.all
  end

  def new
    @bid = @product.bids.build
    @lowest_bid = @product.bids.lowest_bid
  end

  def edit
    @lowest_bid = @product.bids.lowest_bid
  end

  def create
    @bid = @product.bids.build(bid_params)
    @bid.user_id = current_user.id

    if @bid.save
      respond_to do |format|
        format.html { redirect_to products_path }
        format.turbo_stream { flash.now[:notice] = "Bid placed!" }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @bid.update(bid_params)
      respond_to do |format|
        format.html { redirect_to product_path(@bid.product) }
        format.turbo_stream { flash.now[:notice] = "Bid updated!" }
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_product
    @product = Product.find(params[:product_id])
  end

  def set_bid
    @bid = Bid.find(params[:id])
  end

  def bid_params
    params.require(:bid).permit(:amount)
  end
end
