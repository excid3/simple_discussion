require "test_helper"

class SimpleDiscussionTest < ActiveSupport::TestCase
  def test_that_it_has_a_version_number
    refute_nil ::SimpleDiscussion::VERSION
  end
end
