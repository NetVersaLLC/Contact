Contact::Application.routes.draw do
  resources :labels

  get    '/payloads(.:format)', :controller => :payloads, :action => :index
  get    '/payloads/:site_id/:mode_id(.:format)', :controller => :payloads, :action => :load_data
  post   '/payloads(.:format)', :controller => :payloads, :action => :save_data
  get    '/admin', :controller => :payloads, :action => :index

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

  resources :subscriptions
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
    resources :accounts, :only => [:edit, :update, :create]
    resources :codes, :only => [:new, :create]
    resources :downloads, :only => [:new]
    resources :images
    resources :notifications
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
  resources :sites
  resources :users
  resources :accounts
  resources :reports, :except => [:edit, :update]
  resources :dashboard, :only => [:index]

  resources :jobs,  except: [:show]
  get     '/jobs/list(.:format)', :controller => :jobs,   :action => :list

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

  # set up as a nested resource
  #get     '/images(.:format)', :action => 'index', :controller => 'images'
  #post    '/images(.:format)', :action=>"create", :controller=>"images"
  #delete  '/images/:id(.:format)',:action=>"destroy", :controller=>"images"
  #delete  '/images/:id/all(.:format)',:action=>"destroy_all", :controller=>"images"
  #put     '/images/:id(.:format)', :action=>"update", :controller=>"images"

  # make route more rails compliant
  #get     '/images/get_logo/:business_id(.:format)', :action=>"get_logo", :controller=>"images"
  get     '/images/:business_id/get_logo(.:format)', :action=>"get_logo", :controller=>"images"

  get     '/pages/make_redirect', :controller => :pages, :action => :make_redirect

  get     '/begin-sync', :controller => :pages, :action => :begin_sync, :as=>'begin_sync'
  get     '/contact-us', :controller => :pages, :action => :contact_us
  get     '/congratulations', :controller => :pages, :action => :congratulations
  get     '/resellers', :controller => :pages, :action => :resellers
  get     '/support', :controller => :pages, :action => :support
  get     '/terms', :controller => :pages, :action => :terms
  get     '/try_again_later', :controller => :pages, :action => :try_again_later
  
  get     '/leads', :controller => :leads, :action => :show
  post    '/leads', :controller => :leads, :action => :create

  post    '/scanapi/:action', :controller => :scan_api

  match "/watch" => DelayedJobWeb, :anchor => false

  root :to => redirect("/pages/make_redirect")
end
