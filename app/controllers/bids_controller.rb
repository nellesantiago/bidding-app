class BidsController < ApplicationController
  before_action :set_bid, only: %i[ show edit update destroy ]
  before_action :set_product, only: %i[new create edit update]

  def index
    @bids = Bid.all
  end

  def show
  end

  def new
    @bid = @product.bids.build
  end

  def edit
  end

  def create
    @bid = @product.bids.build(bid_params)
    @bid.user_id = current_user.id

    if @bid.save
      redirect_to products_path, notice: "Bid was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @bid.update(bid_params)
      redirect_to product_path(@bid.product), notice: "Bid was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @bid.destroy

    respond_to do |format|
      format.html { redirect_to bids_url, notice: "Bid was successfully destroyed." }
      format.json { head :no_content }
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
