require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(first_name: "Rails", last_name: "Test", email: "rails@email.com", password: "test123", password_confirmation: "test123")
  end

  test "user should be valid" do
    assert @user.save
  end

  test "user should have a first name" do
    @user.first_name = nil
    assert_not @user.save
  end

  test "user should have a last name" do
    @user.last_name = nil
    assert_not @user.save
  end

  test "should have a valid first name" do
    @user.first_name = "Rails123"
    assert_not @user.save
  end

  test "user should have a valid last name" do
    @user.last_name = "Test456"
    assert_not @user.save
  end

  test "user should have an email" do
    @user.email = nil
    assert_not @user.save
  end

  test "user should have a valid email" do
    @user.email = "invalid email"
    assert_not @user.save
  end

  test "user should have a unique email" do
    @user.save
    @user2 = User.new(first_name: "Rails", last_name: "Test", email: @user.email, password: "test123")
    assert_not @user2.save
  end

  test "user email should be case insensitive" do
    email = "tEsT@EmAiL.cOm"
    @user.email = email
    @user.save
    assert_equal email.downcase, @user.email
  end

  test "user should have a password" do
    @user.password = nil
    assert_not @user.save
  end

  test "user should have a valid password" do
    @user.password = "test"
    assert_not @user.save

    @user.password = "test123"
    assert @user.save
  end
end
