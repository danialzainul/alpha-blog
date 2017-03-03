require 'test_helper'

class CreateCategoriesTest < ActionDispatch::IntegrationTest
  
  test "get new category form and create category" do
    get new_category_path
    assert_template 'categories/new'
    # create a new category (sports)
    assert_difference 'Category.count', 1 do
      post_via_redirect categories_path, category: { name: "sports" }
    end
    # after create, redirect to index
    assert_template 'categories/index'
    # check if the page (index) has sports in it
    assert_match "sports", response.body
  end
end