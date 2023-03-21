require "application_system_test_case"

class ProductsTest < ApplicationSystemTestCase
    def setup
        @admin = users(:admin)
        login(@admin)
    end

    test "show all products" do
        assert_text "Products"
    end

    test "add a new product" do
        click_on "+ Add New"

        fill_in "Name", with: "Product"
        fill_in "Description", with: "Product description"
        fill_in "Starting bid price", with: "2000"
        click_on "Create"

        assert_text "Product added!"
    end

    test "edit a product" do
        click_on "Edit", match: :first

        fill_in "Name", with: "Update Product"
        fill_in "Description", with: "This is my updated product"
        click_on "Update"

        assert_text "Product updated!"
    end

    test "delete a product" do
        page.accept_confirm do
         click_on "Delete", match: :first
        end

        assert_text "Product deleted!"
    end
end
