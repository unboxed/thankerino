ThankYouNew::Application.routes.draw do
  devise_for :user

  # resource :account, :controller => "users", :except => [:index]

  # resources :user
  resources :users, :except => [:new, :create]

  resource :thanks

  match "feedbacks" => 'feedbacks#create'
  match "feedbacks/new" => 'feedbacks#new'

  root :to => "thanks#index"
end
