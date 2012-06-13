Contact::Application.routes.draw do

  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  resources :businesses
  resources :map_quests
  resources :results
  resources :tasks
  resources :jobs
  get "yelps/check_email"
  devise_for :users

  get '/downloads', :controller => :downloads, :action => :download
  get '/welcome',   :controller => :pages,     :action => :index
  resources :zip, :only => [:index]
  resources :city, :only => [:index]
  root :to => 'pages#index'
  namespace :user do
    root :to => "businesses#new"
  end
end
