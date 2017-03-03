require 'test_helper'

class CreateCategoriesTest < ActionDispatch::IntegrationTest
  
  test "get new category form and create category" do
    get new_category_path
    assert_template 'categories/new'
    # create a new category (sports) therefore increasing category by 1
    assert_difference 'Category.count', 1 do
      post_via_redirect categories_path, category: { name: "sports" }
    end
    # after create, redirect to index
    assert_template 'categories/index'
    # check if the page (index) has sports in it
    assert_match "sports", response.body
  end
  
  test "invalid category submission results in failure" do
    get new_category_path
    assert_template 'categories/new'
    # create a new category (sports) however no change (invalid)
    assert_no_difference 'Category.count' do
      post categories_path, category: { name: " " }
    end
    # create fails, redirect to new page again
    assert_template 'categories/new'
    # ensure that validation messages are showing up
    # check existence of these two things (views/shared/_errors)
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end
end