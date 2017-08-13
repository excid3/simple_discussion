class SimpleDiscussion::ApplicationController < ::ApplicationController
  layout "simple_discussion"

  def page_number
    page = params.fetch(:page, '').gsub(/[^0-9]/, '').to_i
    page = "1" if page.zero?
    page
  end

  def is_moderator_or_owner?(object)
    is_moderator? || object.user == current_user
  end
  helper_method :is_moderator_or_owner?

  def self.is_moderator?
    current_user.respond_to?(:moderator) && current_user.moderator?
  end
  helper_method :is_moderator?

  def require_moderator_or_author!
    unless is_moderator_or_owner?(@forum_thread)
      redirect_to simple_discussion.root_path, alert: "You aren't allowed to do that."
    end
  end
end
