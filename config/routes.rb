Contact::Application.routes.draw do

  resources :map_quests

  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  resources :businesses
  resources :results
  resources :tasks
  resources :jobs
  resources :home
  get "welcome/index"
  get "yelps/check_email"
  devise_for :users

  namespace :user do
    root :to => "businesses#edit"
  end

  get '/downloads', :controller => :downloads, :action => :download
  root :to => 'welcome#index'
end
