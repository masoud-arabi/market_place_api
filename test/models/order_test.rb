require "test_helper"

class OrderTest < ActiveSupport::TestCase
  setup do 
    @order = orders(:one)
    @pro_one = products(:one)
    @pro_two = products(:two)
  end
  
  test "should have a positive total" do
    order = orders(:one) 
    order.total = -1 
    assert_not order.valid?
  end

  test "should have a positive total" do
    @order.products = @pro_one
    @order.products = @pro_two
    assert_equal @order.products.size, @order.total
  end

end
