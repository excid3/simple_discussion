class SimpleDiscussion::ForumVotesController < SimpleDiscussion::ApplicationController
  CLASS_WHITELIST = ['ForumThread', 'ForumPost']
  before_action :authenticate_user!
  before_action :set_votable
  before_action :set_redirect_path

  def create
    @votable.forum_votes.create(user: current_user)
    redirect_to @redirect_path
  end

  def destroy
    @votable.forum_votes.where(user: current_user).last.try(:destroy)
    redirect_to @redirect_path
  end

  private

    def set_votable
      return unless CLASS_WHITELIST.include?(params[:votable_type])
      @votable = params[:votable_type].safe_constantize.find_by(id: params[:votable_id])
    end

    def set_redirect_path
      @redirect_path = if params[:votable_type] == 'ForumThread'
        @redirect_path = simple_discussion.root_path
      elsif params[:votable_type] == 'ForumPost'
        @redirect_path = simple_discussion.forum_thread_path(@votable.forum_thread)
      end
    end
end
