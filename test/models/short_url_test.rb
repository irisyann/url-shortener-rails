require "test_helper"

class ShortUrlTest < ActiveSupport::TestCase

  # Test for unique short path
  test "short url should be unique" do
    short_url = ShortUrl.new
    short_url.short_path = "abc"
    short_url.num_clicks = 0
    short_url.target_url = TargetUrl.new
    short_url.target_url.target_url = "http://www.google.com"
    short_url.target_url.save
    short_url.save

    short_url2 = ShortUrl.new
    short_url2.short_path = "abc"
    short_url2.num_clicks = 0
    short_url2.target_url = TargetUrl.new
    short_url2.target_url.target_url = "http://www.google.com"
    short_url2.target_url.save

    assert_not short_url2.save
  end


end
