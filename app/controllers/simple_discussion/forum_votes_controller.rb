class SimpleDiscussion::ForumVotesController < SimpleDiscussion::ApplicationController
  CLASS_WHITELIST = ['ForumThread', 'ForumPost']
  before_action :authenticate_user!
  before_action :set_votable

  def create
    @votable.forum_votes.create(user: current_user)
    respond_to { |format| format.js }
  end

  def destroy
    @votable.forum_votes.where(user: current_user).last.try(:destroy)
    respond_to { |format| format.js }
  end

  private

    def set_votable
      return unless CLASS_WHITELIST.include?(params[:votable_type])
      @votable = params[:votable_type].safe_constantize.find_by(id: params[:votable_id])
    end
end
