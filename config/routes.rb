Contact::Application.routes.draw do
  resources :results
  resources :tasks
  resources :jobs
  resources :home
  devise_for :users

  get '/downloads', :controller => :downloads, :action => :download
  root :to => 'home#index'
end
