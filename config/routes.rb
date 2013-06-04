Contact::Application.routes.draw do

  mount UserImpersonate::Engine => "/impersonate", as: "impersonate_engine"

  get    '/payloads/:id(.:format)', :controller => :payloads, :action => :index
  get    '/packages/:id(.:format)', :controller => :packages, :action => :index
  delete '/packages/:id(.:format)', :controller => :packages, :action => :destroy
  post   '/packages/:id(.:format)', :controller => :packages, :action => :create
  resources :google_categories

  devise_for :users,
    :controllers  => {
      :registrations => 'my_devise/registrations',
    }

  resources :booboos
  resources :subscriptions
  resources :pings

  post    '/businesses/save_edits', 
    :controller => :businesses, 
    :action => :save_edits, 
    :as => 'save_edits'
  post    '/businesses/cancel_change', 
    :controller => :businesses, 
    :action => :cancel_change
  post    '/businesses/:id',
    :controller => :businesses, 
    :action => :update
  get    '/businesses/client_checked_in/:id', 
    :controller => :businesses, 
    :action => :client_checked_in,
    :as => 'client_checked_in'
  get    '/businesses/tada/:id', 
    :controller => :businesses, 
    :action => :tada,
    :as => 'tada'

  resources :businesses
  get     '/report(.:format)', :controller => :businesses, :action => :report

  resources :results
  resources :tasks
  resources :places
  resources :zip,  :only => [:index]
  resources :city, :only => [:index]
  resources :terms, :only => [:index]

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

  get     '/categories(.:format)', :controller => :categories, :action => :index
  get     '/categories/:id(.:format)', :controller => :categories, :action => :show
  post    '/categories(.:format)', :controller => :categories, :action => :create

  get     '/pages/make_redirect', :controller => :pages, :action => :make_redirect

  post    '/scanner/start', :controller => :scan, :action => :start
  get     '/scanner/check(.:format)', :controller => :scan, :action => :check
  get     '/scan/:id',      :controller => :scan, :action => :show

  get     '/test/exception', :controller => :test, :action => :exception

  get     '/images(.:format)', :action => 'index', :controller => 'images'
  post    '/images(.:format)', :action=>"create", :controller=>"images"
  delete  '/images/:id(.:format)',:action=>"destroy", :controller=>"images"
  delete  '/images/:id/all(.:format)',:action=>"destroy_all", :controller=>"images"
  put     '/images/:id(.:format)', :action=>"update", :controller=>"images"

  get '/resellers', :controller => :pages, :action => :resellers
  get '/try_again_later', :controller => :pages, :action => :try_again_later

  get '/congratulations', :controller => :pages, :action => :congratulations
  get '/begin-sync', :controller => :pages, :action => :begin_sync, :as=>'begin_sync'

  root :to => redirect("/pages/make_redirect")
  ActiveAdmin.routes(self) # Moved to bottom to resovle Unitialized Dashborad error w activeadmin 0.6.0 
end
