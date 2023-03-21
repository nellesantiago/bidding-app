class ApplicationController < ActionController::Base
  include SessionsHelper
  include ProductsHelper
  include UsersHelper
  before_action :check_expiry

  def check_expiry
    @products_active = Product.where(bidding_status: "active")
    @products_active.each do |product|
      if product.bidding_expiration.past?
        product.update!(bidding_status: "expired")
    end
    end
  end
end
