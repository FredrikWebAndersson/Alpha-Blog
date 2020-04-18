require "test_helper"

class CategoriesControllerTest < ActionDispatch::IntegrationTest

  # dont forget to use a setup merthod
  def setup
    @category = Category.create(name: "sports")
    @user = User.create(username: "John", email: "john@email.com", password: "password", admin: true)
  end

  # test of routes and controllers
  test "should get category index" do
    get categories_path
    assert_response :success
  end

  test "should get new" do 
    sign_in_as(@user, "password") # method using test_helper to simulate a logged in admin user
    get new_category_path
    assert_response :success
  end

  test "should get show" do 
    get category_path(@category)
    assert_response :success
  end

  test "should redirect create when admin not logged in" do
    assert_no_difference "Category.count" do
      post categories_path, params: {category: {name: "sports"}}
    end
    assert_redirected_to categories_path
  end

end

# We need to set the routes to get the paths to be valid 
  # resources :categories

# In rails 5 and up we set the routes with _path and integrations with variable inputs (@category)

# the show path needs an id to be able to identify and show a particular category. 
  # We use the setup method for this !