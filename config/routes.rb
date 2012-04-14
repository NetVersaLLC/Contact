Contact::Application.routes.draw do

  resources :map_quests

  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  resources :businesses
  resources :results
  resources :tasks
  resources :jobs
  get "yelps/check_email"
  devise_for :users

  get '/downloads', :controller => :downloads, :action => :download
  root :to => 'pages#index'
end
