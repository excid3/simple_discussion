SimpleDiscussion::Engine.routes.draw do
  scope module: :simple_discussion do
    resources :forum_threads, path: :threads do
      collection do
        get :answered
        get :unanswered
        get :mine
        get :participating
        get "category/:id", to: "forum_categories#index", as: :forum_category
        get "categories/new", to: "forum_categories#new", as: :new_forum_category
        get "categories/:id/edit", to: "forum_categories#edit", as: :edit_forum_category
        post "categories", to: "forum_categories#create", as: :create_forum_category
        delete "categories/:id", to: "forum_categories#destroy", as: :destroy_forum_category
        patch "categories/:id", to: "forum_categories#update", as: :update_forum_category
      end

      resources :forum_posts, path: :posts do
        member do
          put :solved
          put :unsolved
        end
      end

      resource :notifications
    end
  end

  root to: "simple_discussion/forum_threads#index"
end
