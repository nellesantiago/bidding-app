require "application_system_test_case"

class BidsTest < ApplicationSystemTestCase
    def setup
        @user = users(:user)
        @admin = users(:admin)
    end

    test "show all bids" do
        login(@admin)

        click_on "Bids"

        assert_text "All Bids"
    end

    test "place a bid" do
        login(@user)

        click_on "Place a Bid", match: :first

        assert_text "Place a Bid"

        fill_in 'bid[amount]', with: "2000"
        click_on "commit", match: :first

        assert_text "Bid placed!"
    end

    test "update a bid" do
        login(@user)

        find('.update-bid').click

        assert_text "Update Bid"

        fill_in 'bid[amount]', with: "3000"
        click_on "commit", match: :first

        assert_text "Bid updated!"
    end
end