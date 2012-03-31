Contact::Application.routes.draw do
  resources :jobs
  devise_for :users

  root :to => 'jobs#index'
end
