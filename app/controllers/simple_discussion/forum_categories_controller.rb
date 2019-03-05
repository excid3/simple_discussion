class SimpleDiscussion::ForumCategoriesController < SimpleDiscussion::ApplicationController
  before_action :authenticate_user!, except: :index
  before_action :ensure_user_is_moderator, except: :index
  before_action :set_category, only: [:index, :edit, :update, :destroy]

  def index
    @forum_threads = ForumThread.where(forum_category: @forum_category) if @forum_category.present?
    @forum_threads = @forum_threads.sorted.includes(:user, :forum_category).pinned_first(current_user).paginate(per_page: 10, page: page_number)
    render "simple_discussion/forum_threads/index"
  end

  def new
    @forum_category = ForumCategory.new
  end

  def update
    if @forum_category.update(forum_category_params)
      redirect_to simple_discussion.root_path
    else
      render action: :edit
    end
  end

  def destroy
    general_category = ForumCategory.find_by(slug: 'general')
    @forum_category.forum_threads.each do |ft|
      ft.update(forum_category: general_category)
    end
    @forum_category.destroy
    redirect_to simple_discussion.root_path
  rescue StandardError => error
    flash[:error] = error.message
    redirect_to simple_discussion.root_path
  end

  def create
    @forum_category = ForumCategory.new(forum_category_params)

    if @forum_category.save
      redirect_to simple_discussion.root_path
    else
      render action: :new
    end
  end

  private

    def set_category
      @forum_category = ForumCategory.friendly.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to simple_discussion.forum_threads_path
    end

    def forum_category_params
      params.require(:forum_category).permit(:name, :color)
    end

    def ensure_user_is_moderator
      redirect_to simple_discussion.root_path unless is_moderator?
    end
end
