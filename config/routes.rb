Contact::Application.routes.draw do

  resources :google_categories
  resources :payloads
  resources :packages
  resources :subscriptions

  devise_for :admin_users, ActiveAdmin::Devise.config
  devise_for :users,
    :controllers  => {
      :registrations => 'my_devise/registrations',
    }
  ActiveAdmin.routes(self)

  resources :booboos
  resources :pings
  resources :tweets
  resources :businesses
  resources :map_quests
  resources :results
  resources :tasks
  get     '/jobs(.:format)',     :controller => :jobs,   :action => :index
  post    '/jobs(.:format)',     :controller => :jobs,   :action => :create
  put     '/jobs/:id(.:format)', :controller => :jobs,   :action => :update
  delete  '/jobs/:id(.:format)', :controller => :jobs,   :action => :remove
  get     '/jobs/list(.:format)',:controller => :jobs,   :action => :list
  post    '/bing/save_hotmail',  :controller => :bing,   :action => :save_hotmail
  post    '/yahoo/save_email',   :controller => :yahoo,  :action => :save_email
  post    '/google/save_email',  :controller => :google, :action => :save_email
  get     "/yelps/check_email"
  post    '/captcha/recaptcha',      :controller => :captcha,         :action => :recaptcha
  get     '/downloads/:business_id', :controller => :downloads,       :action => :download
  get     '/welcome',                :controller => :pages,           :action => :index
  get     '/emails/check/:site',     :controller => :emails,          :action => :check
  post    '/detect',                 :controller => :detect_settings, :action => :detect

  resources :zip,  :only => [:index]
  resources :city, :only => [:index]
  resources :places
  root :to => 'pages#index'
end
