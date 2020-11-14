class CreateCategoriesTest < ActionDispatch::IntegrationTest
  test "get new category form and create category" do 
    get new_category_url
    assert_template 'categories/new'
    assert_difference 'Category.count', 1 do 
      post categories_url, params: { category: { name: 'sports' }}
    end
    get categories_url
    assert_match 'sports', response.body
  end

  test "invalid category submission results in failure" do 
    get new_category_url
    assert_template 'categories/new'
    assert_no_difference 'Category.count' do 
      post categories_url, params: { category: { name: ' ' }}
    end
    get new_category_url
  end
end