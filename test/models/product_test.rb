require "test_helper"

class ProductTest < ActiveSupport::TestCase

  test "should have a positive price" do
    product = products(:one) 
    product.price = -1 
    assert_not product.valid?
  end

  test "should filter products by name" do
    assert_equal 2, Product.filter_by_title('tv').count
  end
  
  test 'should filter products by name and sort them' do 
    assert_equal [products(:another_tv), products(:one)],
    Product.filter_by_title('tv').sort 
  end

  test "should filter products by price equal or above" do
    assert_equal 2, Product.above_or_equal_to_price(200).count
    assert_equal [products(:two), products(:one)],
    Product.above_or_equal_to_price(200).sort
  end

  test "should filter products by price equal or lower" do
    assert_equal 2, Product.lower_or_equal_to_price(200).count
    assert_equal [products(:another_tv), products(:last_tv)].sort,
    Product.lower_or_equal_to_price(200)
  end

  test "should sort products by data creation" do
    products(:two).touch
    assert_equal Product.recent.to_a, [products(:last_tv),
    products(:another_tv), products(:one), products(:two)]
  end

  test 'search should not find "videogame" and "100" as min price' do 
    search_hash = {keyword: 'videogame', min_price: 100}
    assert Product.search(search_hash).empty?
  end

  test 'search should find cheap TV' do 
    search_hash = { keyword: 'Cheapi', min_price: 50, max_price: 150 }
    assert_equal Product.search(search_hash), [products(:last_tv)]
  end

  test 'should get all products when no parameters' do 
    search_hash = {}
    assert_equal Product.search(search_hash), Product.all.to_a
  end
  test 'search should filter by product ids' do 
    search_hash = {product_ids: [products(:one).id]}
    assert_equal [products(:one)], Product.search(search_hash)
  end
end
