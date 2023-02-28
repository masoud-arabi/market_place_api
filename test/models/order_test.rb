require "test_helper"

class OrderTest < ActiveSupport::TestCase
  setup do 
    @order = orders(:one)
    @product2 = products(:one)
    @product1 = products(:two)
  end

  test "should set a total" do
    order = Order.new user_id: @order.user.id
    order.products << products(:one) 
    order.products << products(:two)
    order.save
    assert_equal (@product1.price + @product2.price), order.total
  end

end
