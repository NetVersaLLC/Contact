Contact::Application.routes.draw do
  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  resources :yelps

  resources :businesses

  resources :results
  resources :tasks
  resources :jobs
  resources :home
  devise_for :users

  get '/downloads', :controller => :downloads, :action => :download
  root :to => 'home#index'
end
