require "test_helper"

class ForumTest < ActionDispatch::IntegrationTest
  test "get index" do
    get "/"
    assert_response :success
    assert_match "Community", response.body
  end
end
