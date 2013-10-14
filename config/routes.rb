Contact::Application.routes.draw do

  #mount UserImpersonate::Engine => "/impersonate", as: "impersonate_engine"

  get    '/payloads/:id(.:format)', :controller => :payloads, :action => :index
  get    '/packages/:id(.:format)', :controller => :packages, :action => :index
  delete '/packages/:id(.:format)', :controller => :packages, :action => :destroy
  post   '/packages/:id(.:format)', :controller => :packages, :action => :create
  post   '/packages/:id/reorder(.:format)', :controller => :packages, :action => :reorder
  resources :google_categories

  devise_for :users,
    :controllers  => {
      :registrations => 'my_devise/registrations',
  
    }
  devise_scope :user do 
      get '/users/sign_up/process_coupon', :to => 'my_devise/registrations#process_coupon' 
  end 

  resources :booboos
  resources :subscriptions
  resources :pings
  resources :payload_nodes, only: [:index, :create]

  resources :businesses 
  get    '/businesses/client_checked_in/:id', 
    :controller => :businesses, 
    :action => :client_checked_in,
    :as => 'client_checked_in'
  get    '/businesses/tada/:id', 
    :controller => :businesses, 
    :action => :tada,
    :as => 'tada'

  get    '/impersonate', to: 'impersonate#index' 
  get    '/impersonate/:id', to: 'impersonate#new', as: :new_impersonation
  delete '/impersonate/revert', to: 'impersonate#revert', as: :revert_impersonation
  get    '/credentials(.:format)', :controller => :impersonate, :action => :credentials

  resources :notifications 

  resources :businesses do 
    resources :codes, :only => [:new, :create] 
    resources :accounts, :only => [:edit, :update, :create]
    resources :notifications
    resources :downloads, :only => [:show]
  end 

  get     '/codes/:business_id/:site_name(.:format)', :action=>"site_code", :controller=>"codes"
  post    '/codes/:business_id/:site_name(.:format)', :action=>"create",    :controller=>"codes"
  delete  '/codes/:business_id/:site_name(.:format)', :action=>"destroy",   :controller=>"codes"

  get     '/report(.:format)', :controller => :businesses, :action => :report

  resources :results
  resources :tasks
  resources :places
  resources :zip,  :only => [:index]
  resources :city, :only => [:index]
  resources :terms, :only => [:index]
  resources :site_profiles
  resources :users
  resources :accounts

  resources :jobs,  except: [:show]
  get     '/jobs/list(.:format)', :controller => :jobs,   :action => :list

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


  get     '/categories(.:format)', :controller => :categories, :action => :index
  get     '/categories/:id(.:format)', :controller => :categories, :action => :show
  post    '/categories(.:format)', :controller => :categories, :action => :create


  post    '/scanner/start', :controller => :scan, :action => :start
  get     '/scanner/check(.:format)', :controller => :scan, :action => :check
  post    '/scanner/email', :controller => :scan, :action => :email
  post    '/scanner/send', :controller => :scan, :action => :send_email
  get     '/scan/:id',      :controller => :scan, :action => :show

  get     '/test/exception', :controller => :test, :action => :exception

  get     '/images(.:format)', :action => 'index', :controller => 'images'
  post    '/images(.:format)', :action=>"create", :controller=>"images"
  delete  '/images/:id(.:format)',:action=>"destroy", :controller=>"images"
  delete  '/images/:id/all(.:format)',:action=>"destroy_all", :controller=>"images"
  put     '/images/:id(.:format)', :action=>"update", :controller=>"images"
  put     '/images/set_logo/:id(.:format)', :action=>"set_logo", :controller=>"images"
  get     '/images/get_logo/:business_id(.:format)', :action=>"get_logo", :controller=>"images"

  get     '/pages/make_redirect', :controller => :pages, :action => :make_redirect

  get     '/begin-sync', :controller => :pages, :action => :begin_sync, :as=>'begin_sync'
  get     '/contact-us', :controller => :pages, :action => :contact_us
  get     '/congratulations', :controller => :pages, :action => :congratulations
  get     '/dashboard', :controller => :pages, :action => :dashboard
  get     '/resellers', :controller => :pages, :action => :resellers
  get     '/support', :controller => :pages, :action => :support
  get     '/try_again_later', :controller => :pages, :action => :try_again_later
  
  get     '/leads', :controller => :leads, :action => :show
  post    '/leads', :controller => :leads, :action => :create

  post    '/scanapi/:action', :controller => :scan_api

  match "/watch" => DelayedJobWeb, :anchor => false

  root :to => redirect("/pages/make_redirect")
  ActiveAdmin.routes(self) # Moved to bottom to resovle Unitialized Dashborad error w activeadmin 0.6.0 
end
