class SimpleDiscussion::PinsController < SimpleDiscussion::ApplicationController
  before_action :authenticate_user!
  before_action :set_forum_thread

  def create
    @forum_thread.toggle_pin(current_user)
    redirect_to :back
  end

  private

    def set_forum_thread
      @forum_thread = ForumThread.friendly.find(params[:forum_thread_id])
    end
end
