require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "user with a valid user should be valid" do
    user = User.new(email: 'test@one.org', password_digest: '123456')
    assert user.valid?
  end
  test "user with a invalid email should be invalid" do
    user = User.new(email: 'one', password_digest: '123456')
    assert_not user.valid?
  end
  test "new user with an exist email should be invalid" do
    other_user = users(:one)
    user = User.new(email: other_user.email, password_digest: '123456')
    assert_not user.valid?
  end
end
