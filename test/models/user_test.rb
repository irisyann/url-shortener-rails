require "test_helper"

class UserTest < ActiveSupport::TestCase
  
  # test valid email
  test "valid email" do
    user = User.new
    user.email = "test@test.com"
    user.password = "test123"
    user.password_confirmation = "test123"
    assert user.valid?
  end

  # test invalid email
  test "invalid email" do
    user = User.new
    user.email = "test.com"
    user.password = "test123"
    user.password_confirmation = "test123"
    assert_not user.valid?
  end
  
end
