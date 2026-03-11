require "minitest/autorun"

class NonJsActionsTest < Minitest::Test
  def test_forum_post_template_uses_button_to_for_mutating_actions
    source = File.read(File.expand_path("../../app/views/simple_discussion/forum_posts/_forum_post.html.erb", __dir__))

    assert_match(/button_to\s+simple_discussion\.forum_thread_forum_post_path\(@forum_thread,\s*forum_post\),\s*method:\s*:delete/m, source)
    assert_match(/button_to\s+t\('undo'\),\s*simple_discussion\.unsolved_forum_thread_forum_post_path\(@forum_thread,\s*forum_post\),\s*method:\s*:put/m, source)
    assert_match(/button_to\s+simple_discussion\.solved_forum_thread_forum_post_path\(@forum_thread,\s*forum_post\),\s*method:\s*:put/m, source)

    refute_includes source, "link_to icon(\"fas\",\"trash\"), simple_discussion.forum_thread_forum_post_path(@forum_thread, forum_post)"
    refute_includes source, "link_to t('undo'), simple_discussion.unsolved_forum_thread_forum_post_path(@forum_thread, forum_post), method: :put"
    refute_includes source, "link_to simple_discussion.solved_forum_thread_forum_post_path(@forum_thread, forum_post), method: :put do"
  end

  def test_layout_template_uses_button_to_for_notifications
    source = File.read(File.expand_path("../../app/views/layouts/simple_discussion.html.erb", __dir__))

    assert_match(/button_to\s+simple_discussion\.forum_thread_notifications_path\(@forum_thread\),\s*method:\s*:post/m, source)
    refute_match(/link_to\s+simple_discussion\.forum_thread_notifications_path\(@forum_thread\),\s*method:\s*:post/m, source)
  end
end
