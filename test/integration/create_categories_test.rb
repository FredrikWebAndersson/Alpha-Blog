require "test_helper"

class CreateCategoriesTest < ActionDispatch::IntegrationTest

  # Testing for Create Category feature
  test "get new category form and create category" do
    get new_category_path
    assert_template "categories/new"
    assert_difference "Category.count", 1 do
      post categories_path, params:{category: {name: "sports"}} 
      follow_redirect!
    end
     assert_template "categories/index"
     assert_match "sports", response.body 
  end

  # Testing for invalide Category
  test "invalid category submission results in failure" do 
    get new_category_path
    assert_template "categories/new"
    assert_no_difference  "Category.count" do
      post categories_path, params:{category: {name: " "}} 
    end
     assert_template "categories/new"
     assert_select "h4.alert-heading"
  end

end

# assert_template needs a gem 
  # add rails-controller-testing' to Gemfile and run bundle install
