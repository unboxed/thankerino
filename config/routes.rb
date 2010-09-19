ThankYouNew::Application.routes.draw do
  resource :account, :controller => "users"
  resources :user
  resources :users, :only => [:index]

  resource :user_session
  resource :thanks

  root :to => "thanks#index"
end
