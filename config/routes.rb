Contact::Application.routes.draw do

  get    '/payloads/:id(.:format)', :controller => :payloads, :action => :index
  get    '/packages/:id(.:format)', :controller => :packages, :action => :index
  delete '/packages/:id(.:format)', :controller => :packages, :action => :destroy
  post   '/packages/:id(.:format)', :controller => :packages, :action => :create
  resources :google_categories

  devise_for :users,
    :controllers  => {
      :registrations => 'my_devise/registrations',
    }
  ActiveAdmin.routes(self)

  resources :booboos
  resources :subscriptions
  resources :pings
  resources :businesses
  get     '/report(.:format)', :controller => :businesses, :action => :report

  resources :results
  resources :tasks
  resources :places
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
  post    '/captcha/:type',      :controller => :captcha,         :action => :recaptcha
  get     '/downloads/:business_id', :controller => :downloads,       :action => :download
  get     '/emails/check/:site',     :controller => :emails,          :action => :check

  get     '/contact-us', :controller => :pages, :action => :contact_us

  get     '/bunnies(.:format)', :controller => :categories, :action => :index
  get     '/bunnies/:id(.:format)', :controller => :categories, :action => :show
  post    '/bunnies(.:format)', :controller => :categories, :action => :create

  get     '/pages/make_redirect', :controller => :pages, :action => :make_redirect

  get     '/scan', :controller => :scan, :action => :index
  get     '/scan/sites(.:format)', :controller => :scan, :action => :sites
  get     '/scan/sites/:id(.:format)', :controller => :scan, :action => :site
  get     '/scan/status/:id(.:format)', :controller => :scan, :action => :status

  get     '/images/:id(.:format)', :action => 'index', :controller => 'images'
  post    '/images(.:format)', :action=>"create", :controller=>"images"
  delete  '/images/:id(.:format)',:action=>"destroy", :controller=>"images"
  delete  '/images/:id/all(.:format)',:action=>"destroy_all", :controller=>"images"
  put     '/images/:id(.:format)', :action=>"update", :controller=>"images"

  root :to => redirect("/pages/make_redirect")
end
