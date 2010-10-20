ThankYouNew::Application.routes.draw do
  devise_for :user

  # resource :account, :controller => "users", :except => [:index]

  # resources :user
  resources :users

  resource :thanks

  root :to => "thanks#index"
end
