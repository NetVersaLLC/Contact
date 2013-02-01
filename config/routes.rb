Contact::Application.routes.draw do

  # This line mounts Refinery's routes at the root of your application.
  # This means, any requests to the root URL of your application will go to Refinery::PagesController#home.
  # If you would like to change where this extension is mounted, simply change the :at option to something different.
  #
  # We ask that you don't use the :as option here, as Refinery relies on it being the default of "refinery"
  mount Refinery::Core::Engine, :at => '/c'


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
  resources :businesses
  resources :results
  resources :tasks
  resources :zip,  :only => [:index]
  resources :city, :only => [:index]

  get     '/jobs(.:format)',     :controller => :jobs,   :action => :index
  post    '/jobs(.:format)',     :controller => :jobs,   :action => :create
  put     '/jobs/:id(.:format)', :controller => :jobs,   :action => :update
  delete  '/jobs/:id(.:format)', :controller => :jobs,   :action => :remove
  get     '/jobs/list(.:format)',:controller => :jobs,   :action => :list

  post    '/accounts(.:format)', :controller => :accounts,   :action => :create
  # Bing 
  get     '/bing_category(.:format)',  :controller => :bing,   :action => :bing_category

  # Yahoo 
  post    '/yahoo/save_email(.:format)',   :controller => :yahoo,  :action => :save_email
  get     '/yahoo_category(.:format)',  :controller => :yahoo,   :action => :yahoo_category

  # Yelp
  get     "/yelps/check_email"
  get     '/yelp_category(.:format)',  :controller => :yelp,   :action => :yelp_category

  post    '/google/save_email',  :controller => :google, :action => :save_email
  post    '/captcha/recaptcha',      :controller => :captcha,         :action => :recaptcha
  get     '/downloads/:business_id', :controller => :downloads,       :action => :download
  get     '/emails/check/:site',     :controller => :emails,          :action => :check

  get     '/contact-us', :controller => :pages, :action => :contact_us
  resources :places
  root :to => 'pages#index'
end
