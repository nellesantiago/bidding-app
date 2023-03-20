require "test_helper"

class BidTest < ActiveSupport::TestCase
  def setup
    @product = products(:product1)
    @user = users(:user)
    @bid = Bid.new(amount: 100, product_id: @product.id, user_id: @user.id)
  end

  test "bid should be valid" do
    assert @bid.save
  end

  test "bid should have an amount" do
    @bid.amount = nil
    assert_not @bid.save
  end

  test "bid should have a user" do
    @bid.user_id = nil
    assert_not @bid.save
  end

  test "bid should have a product" do
    @bid.product_id = nil
    assert_not @bid.save
  end

  test "bid amount should be greater than or equal to starting bid price" do
    @starting_bid_price = @bid.product.starting_bid_price
    @bid.amount = @starting_bid_price
    assert @bid.save

    @bid.amount = @starting_bid_price - 1
    assert_not @bid.save

    @bid.amount = @starting_bid_price + 1
    assert @bid.save
  end
end