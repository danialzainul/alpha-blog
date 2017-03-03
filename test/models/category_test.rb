require 'test_helper'

# assert is used to ensure test is TRUE 
# if @category.valid => true, test will pass as both is true

# assert_not is used to ensure test is FALSE
# if @category.valid => false, test will pass as both is false
# means assert_not => false, @category.valid => false
# false false => test will PASS

class CategoryTest < ActiveSupport::TestCase
  def setup
    @category = Category.new(name: "sports")
  end
  
  test "category should be valid" do
    assert @category.valid?
  end
  
  test "name should be present" do
    # assert_not is to test a negative (we want it to be false)
    # if @category.valid? returns true, it means the test FAIL
    # the test will PASS if @category.valid? returns FALSE (not valid)
    @category.name = " "
    assert_not @category.valid?
  end
  
  test "name should be unique" do
    # category2 should not be valid, we already have sports category
    @category.save
    category2 = Category.new(name: "sports")
    assert_not category2.valid?
  end
  
  test "name should not be too long" do
    # creates @category with 26 chars, which FAILS
    # name needs to be be less than 25
    @category.name = "a" * 26
    assert_not @category.valid?
  end

  test "name should not be too short" do
    # name more than 2 chars
    @category.name = "aa"
    assert_not @category.valid?
  end

end