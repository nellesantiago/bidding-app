require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase
  def setup
    @user = users(:user)
    @admin = users(:admin)
    visit root_path
  end 

  test "log in with valid credentials" do
    login(@user)
    click_on "Settings"
    assert_text "Delete Account"
  end

  test "log out" do
    login(@user)

    click_on "Log out"
    assert_text "Get Started"
  end

  test "create a new account" do
    click_on "Sign up"

    assert_text "Already have an account? Log in!"

    fill_in "First name", with: "Rails"
    fill_in "Last name", with: "Test"
    fill_in "Email address", with: "rails@test.com"
    fill_in "Password", with: "123456"
    fill_in "Confirm Password", with: "123456"

    click_on "Sign up"

    assert_text "Welcome, Rails!"
  end

  test "edit account details" do
    login(@user)

    click_on "Settings"
    assert_text "Account Settings"
    
    fill_in "First name", with: "New"
    click_on "Save Changes"

    assert_text "Account updated!"
  end

  test "delete account" do
    login(@user)

    click_on "Settings"
    
    page.accept_confirm do
      click_on "Continue to account deletion"
    end

    assert_text "Account deleted!"
  end

  test "log in as admin" do
    login(@admin)

    assert_text "Users"
  end

  test "view all users" do
    login(@admin)

    click_on "Users"
    assert_text "All Users"
  end

  test "delete a user as an admin" do
    login(@admin)

    click_on "Users"

    page.accept_confirm do
      click_on "Delete User", match: :first
    end

    assert_text "User deleted!"
  end
end