require "test_helper"

class CategoriesControllerTest < ActionDispatch::IntegrationTest

  # dont forget to use a setup merthod
  def setup
    @category = Category.create(name: "sports")
  end

  # test of routes and controllers
  test "should get category index" do
    get categories_path
    assert_response :success
  end

  test "should get new" do 
    get new_category_path
    assert_response :success
  end

  test "should get show" do 
    get category_path(@category)
    assert_response :success
  end

end

# We need to set the routes to get the paths to be valid 
  # resources :categories

# In rails 5 and up we set the routes with _path and integrations with variable inputs (@category)

# the show path needs an id to be able to identify and show a particular category. 
  # We use the setup method for this !