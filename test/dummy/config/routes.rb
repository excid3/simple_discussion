Rails.application.routes.draw do
  devise_for :users
  mount SimpleDiscussion::Engine => "/"
end
