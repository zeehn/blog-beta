class ListCategoriesTest < ActionDispatch::IntegrationTest 
  def setup
    @category = Category.new(name: "sports")
    @category2 = Category.new(name: "technology")
  end

  test "should show categories listing" do 
    get categories_url
    assert_template "categories/index"
    assert_select "h3", "All Categories Listing"
  end

end