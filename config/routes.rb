ThankYouNew::Application.routes.draw do

  resources :scoreboards

  devise_for :user

  # resource :account, :controller => "users", :except => [:index]

  # resources :user
  resources :users, :except => [:new]

  resource :thanks

  scope "/admin" do
    resource :import
    resources :groups
    match "delete_points" => 'administration#destroy'
  end

  match "admin" => 'administration#index'

  match "feedbacks" => 'feedbacks#create'
  match "feedbacks/new" => 'feedbacks#new'

  root :to => "thanks#index"
  match 'create_thanks_from_iphone' => 'thanks#create_thanks_from_iphone'
end
