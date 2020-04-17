require "test_helper"

class CategoryTest < ActiveSupport::TestCase

  #runs before every test we run
  def setup 
    @category = Category.new(name: "sports")
  end

  # this is an action record Assertion
  test "Category should be valid" do 
    assert @category.valid?
  end

  test "name should be present" do 
    @category.name = " "
    assert_not @category.valid?
  end

  test "name should be unique" do
    @category.save
    category2 = Category.new(name: "sports")
    assert_not category2.valid?
  end

  test "name should not be too long" do 
    @category.name = "a" * 26 #create a string of 26 characters, we xant max 25
    assert_not @category.valid?
  end

  test "name should not be too short" do
    @category.name = "aa" # we want a minimum of 3 characters
    assert_not @category.valid?
  end

end
