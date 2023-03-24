require "test_helper"

class TargetUrlTest < ActiveSupport::TestCase
  
  # Test for valid URL
  test "valid URL" do
    target_url = TargetUrl.new
    target_url.target_url = "http://www.google.com"
    assert target_url.valid?
  end

  # Test for invalid URL
  test "invalid URL" do
    target_url = TargetUrl.new
    target_url.target_url = "google.com"
    assert_not target_url.valid?
  end

end
