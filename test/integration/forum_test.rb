require "test_helper"

class ForumTest < ActionDispatch::IntegrationTest
  include SimpleDiscussion::Engine.routes.url_helpers

  test "threads index" do
    get "/"
    assert_response :success
    assert_match "Community", response.body
  end

  test "categories" do
    get forum_category_forum_threads_path(forum_categories(:general))
    assert_response :success
  end

  test "show forum thread" do
    get forum_thread_path(forum_threads(:hello))
    assert_response :success
  end
end
