Contact::Application.routes.draw do

  resources :google_categories
  resources :payloads
  resources :failed_jobs
  resources :completed_jobs

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  resources :booboos
  resources :pings
  resources :tweets
  resources :businesses
  resources :map_quests
  resources :results
  resources :tasks
  resources :jobs
  get "yelps/check_email"
  devise_for :users

  get '/downloads/:business_id', :controller => :downloads, :action => :download
  get '/welcome',   :controller => :pages,     :action => :index
  resources :zip, :only => [:index]
  resources :city, :only => [:index]
  resources :places
  root :to => 'pages#index'
  namespace :user do
    root :to => "businesses#new"
  end
end
