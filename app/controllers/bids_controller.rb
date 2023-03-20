class BidsController < ApplicationController
  before_action :set_bid, only: %i[ show edit update destroy ]

  def index
    @bids = Bid.all
  end

  def show
  end

  def new
    @bid = Bid.new
  end

  def edit
  end

  def create
    @bid = Bid.new(bid_params)

    respond_to do |format|
      if @bid.save
        format.html { redirect_to bid_url(@bid), notice: "Bid was successfully created." }
        format.json { render :show, status: :created, location: @bid }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @bid.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @bid.update(bid_params)
        format.html { redirect_to bid_url(@bid), notice: "Bid was successfully updated." }
        format.json { render :show, status: :ok, location: @bid }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @bid.errors, status: :unprocessable_entity }
      end
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

    def set_bid
      @bid = Bid.find(params[:id])
    end

    def bid_params
      params.require(:bid).permit(:amount, :user_id, :product_id)
    end
end
