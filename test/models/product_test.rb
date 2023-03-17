require "test_helper"

class ProductTest < ActiveSupport::TestCase
  def setup
    @admin = users(:admin)
    @product = Product.new(name: "Product", description: "Test", starting_bid_price: 100, bidding_expiration: DateTime.now + 31.days, bidding_status: "active", user_id: @admin.id)
  end

  test "product should have valid attributes" do
    assert @product.save
  end

  test "product should have a name" do
    @product.name = nil
    assert_not @product.save
  end

  test "product should have a description" do
    @product.description = nil
    assert_not @product.save
  end

  test "product should have a starting bid price" do
    @product.starting_bid_price = nil
    assert_not @product.save
  end

  test "starting bid price should be greater than 0" do
    @product.starting_bid_price = 0
    assert_not @product.save
  end

  test "product should expire after 7 days by default" do
    @product.bidding_expiration = nil
    @product.save
    assert_equal @product.bidding_expiration.strftime("%a, %d %b %Y %I:%M %p"), 7.days.from_now.strftime("%a, %d %b %Y %I:%M %p")
  end

  test "name should not exceed maximum of 20 characters" do
    @product.name = "abcdefghijklmnopqrstuvwxyz"
    assert_not @product.save
  end

  test "product user should be admin" do
    assert_equal "admin", @product.user.role
  end

  test "product should be active by default" do
    assert_equal "active", @product.bidding_status
  end

  test "product expiration date should be later than current date" do
    @product.bidding_expiration = 1.day.ago
    assert_not @product.save
  end

end
