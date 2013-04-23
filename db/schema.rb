# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130423153756) do

  create_table "accounts", :force => true do |t|
    t.integer  "business_id"
    t.string   "email"
    t.string   "username"
    t.integer  "port"
    t.string   "address"
    t.text     "secrets"
    t.datetime "force_update"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "connection_type"
  end

  add_index "accounts", ["business_id"], :name => "index_accounts_on_business_id"
  add_index "accounts", ["email"], :name => "index_accounts_on_email"

  create_table "active_admin_comments", :force => true do |t|
    t.string   "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "admin_users", :force => true do |t|
    t.string   "email",                  :default => "",    :null => false
    t.string   "encrypted_password",     :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "label_id"
    t.boolean  "admin",                  :default => false
  end

  add_index "admin_users", ["email"], :name => "index_admin_users_on_email", :unique => true
  add_index "admin_users", ["label_id"], :name => "index_admin_users_on_label_id"
  add_index "admin_users", ["reset_password_token"], :name => "index_admin_users_on_reset_password_token", :unique => true

  create_table "adsolutionsyp_categories", :force => true do |t|
    t.integer  "parent_id"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "adsolutionsyp_categories", ["name"], :name => "index_adsolutionsyp_categories_on_name"
  add_index "adsolutionsyp_categories", ["parent_id"], :name => "index_adsolutionsyp_categories_on_parent_id"

  create_table "adsolutionsyps", :force => true do |t|
    t.integer  "business_id"
    t.string   "email"
    t.string   "secret_answer"
    t.text     "secrets"
    t.datetime "force_update"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
    t.integer  "adsolutionsyp_category_id"
  end

  create_table "affiliates", :force => true do |t|
    t.string   "name"
    t.string   "code"
    t.boolean  "active"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "affiliates", ["code"], :name => "index_affiliates_on_code"

  create_table "angies_list_categories", :force => true do |t|
    t.integer  "parent_id"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "angies_list_categories", ["name"], :name => "index_angies_list_categories_on_name"
  add_index "angies_list_categories", ["parent_id"], :name => "index_angies_list_categories_on_parent_id"

  create_table "angies_lists", :force => true do |t|
    t.integer  "business_id"
    t.string   "email"
    t.text     "secrets"
    t.string   "status"
    t.datetime "force_update"
    t.string   "listing_url"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
    t.integer  "angies_list_category_id"
  end

  add_index "angies_lists", ["business_id"], :name => "index_angies_lists_on_business_id"

  create_table "aols", :force => true do |t|
    t.integer  "business_id"
    t.datetime "force_update"
    t.text     "secrets"
    t.string   "username"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "aols", ["username"], :name => "index_aols_on_username"

  create_table "bing_categories", :force => true do |t|
    t.integer  "parent_id"
    t.string   "name"
    t.string   "name_path"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "bing_categories", ["name_path"], :name => "index_bing_categories_on_name_path"
  add_index "bing_categories", ["parent_id"], :name => "index_bing_categories_on_parent_id"

  create_table "bings", :force => true do |t|
    t.integer  "business_id"
    t.string   "local_url"
    t.string   "email"
    t.text     "secrets"
    t.string   "status"
    t.datetime "force_update"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.integer  "bing_category_id"
  end

  add_index "bings", ["business_id"], :name => "index_bings_on_business_id"

  create_table "booboos", :force => true do |t|
    t.integer  "user_id"
    t.integer  "business_id"
    t.text     "message"
    t.string   "ip"
    t.string   "user_agent"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "browser"
    t.string   "osversion"
  end

  add_index "booboos", ["business_id"], :name => "index_booboos_on_business_id"
  add_index "booboos", ["user_id"], :name => "index_booboos_on_user_id"

  create_table "businesscoms", :force => true do |t|
    t.datetime "force_update"
    t.text     "secrets"
    t.integer  "business_id"
    t.string   "email"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.string   "username"
  end

  add_index "businesscoms", ["business_id"], :name => "index_businesscoms_on_business_id"

  create_table "businessdb_categories", :force => true do |t|
    t.integer  "parent_id"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "businessdb_categories", ["name"], :name => "index_businessdb_categories_on_name"
  add_index "businessdb_categories", ["parent_id"], :name => "index_businessdb_categories_on_parent_id"

  create_table "businessdbs", :force => true do |t|
    t.datetime "force_update"
    t.text     "secrets"
    t.integer  "business_id"
    t.string   "email"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
    t.integer  "businessdb_category_id"
  end

  add_index "businessdbs", ["business_id"], :name => "index_businessdbs_on_business_id"

  create_table "businesses", :force => true do |t|
    t.integer  "user_id"
    t.string   "business_name"
    t.string   "corporate_name"
    t.string   "contact_gender"
    t.string   "contact_prefix"
    t.string   "contact_first_name"
    t.string   "contact_middle_name"
    t.string   "contact_last_name"
    t.string   "local_phone"
    t.string   "alternate_phone"
    t.string   "toll_free_phone"
    t.string   "mobile_phone"
    t.boolean  "mobile_appears"
    t.string   "fax_number"
    t.string   "address"
    t.string   "address2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.boolean  "open_24_hours"
    t.boolean  "open_by_appointment"
    t.boolean  "monday_enabled"
    t.boolean  "tuesday_enabled"
    t.boolean  "wednesday_enabled"
    t.boolean  "thursday_enabled"
    t.boolean  "friday_enabled"
    t.boolean  "saturday_enabled"
    t.boolean  "sunday_enabled"
    t.string   "monday_open"
    t.string   "monday_close"
    t.string   "tuesday_open"
    t.string   "tuesday_close"
    t.string   "wednesday_open"
    t.string   "wednesday_close"
    t.string   "thursday_open"
    t.string   "thursday_close"
    t.string   "friday_open"
    t.string   "friday_close"
    t.string   "saturday_open"
    t.string   "saturday_close"
    t.string   "sunday_open"
    t.string   "sunday_close"
    t.boolean  "accepts_cash"
    t.boolean  "accepts_checks"
    t.boolean  "accepts_mastercard"
    t.boolean  "accepts_visa"
    t.boolean  "accepts_discover"
    t.boolean  "accepts_diners"
    t.boolean  "accepts_amex"
    t.boolean  "accepts_paypal"
    t.boolean  "accepts_bitcoin"
    t.text     "business_description"
    t.string   "professional_associations"
    t.string   "geographic_areas"
    t.string   "year_founded"
    t.string   "company_website"
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.datetime "created_at",                                 :null => false
    t.datetime "updated_at",                                 :null => false
    t.datetime "client_checkin"
    t.string   "category1"
    t.string   "category2"
    t.string   "category3"
    t.integer  "subscription_id"
    t.string   "contact_birthday"
    t.integer  "captcha_solves",            :default => 200
    t.string   "category4"
    t.string   "category5"
    t.boolean  "categorized"
    t.integer  "label_id",                  :default => 1
  end

  add_index "businesses", ["category1"], :name => "index_businesses_on_category1"
  add_index "businesses", ["category2"], :name => "index_businesses_on_category2"
  add_index "businesses", ["category3"], :name => "index_businesses_on_category3"
  add_index "businesses", ["user_id"], :name => "index_businesses_on_user_id"

  create_table "citisquare_categories", :force => true do |t|
    t.integer  "parent_id"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "citisquare_categories", ["name"], :name => "index_citisquare_categories_on_name"
  add_index "citisquare_categories", ["parent_id"], :name => "index_citisquare_categories_on_parent_id"

  create_table "citisquares", :force => true do |t|
    t.datetime "force_update"
    t.text     "secrets"
    t.integer  "business_id"
    t.string   "email"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
    t.integer  "citisquare_category_id"
  end

  add_index "citisquares", ["business_id"], :name => "index_citisquares_on_business_id"
  add_index "citisquares", ["citisquare_category_id"], :name => "index_citisquares_on_citisquare_category_id"

  create_table "citysearches", :force => true do |t|
    t.integer  "business_id"
    t.string   "email"
    t.string   "listing_url"
    t.boolean  "facebook_signin"
    t.text     "secrets"
    t.string   "status"
    t.datetime "force_update"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "citysearches", ["business_id"], :name => "index_citysearches_on_business_id"

  create_table "completed_jobs", :force => true do |t|
    t.integer  "business_id"
    t.string   "name"
    t.text     "data_generator"
    t.integer  "status"
    t.text     "status_message"
    t.text     "payload"
    t.text     "returned"
    t.datetime "waited_at"
    t.integer  "position"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "completed_jobs", ["business_id"], :name => "index_completed_jobs_on_business_id"
  add_index "completed_jobs", ["status"], :name => "index_completed_jobs_on_status"

  create_table "cornerstonesworld_categories", :force => true do |t|
    t.integer  "parent_id"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "cornerstonesworld_categories", ["name"], :name => "index_cornerstonesworld_categories_on_name"
  add_index "cornerstonesworld_categories", ["parent_id"], :name => "index_cornerstonesworld_categories_on_parent_id"

  create_table "cornerstonesworlds", :force => true do |t|
    t.integer  "business_id"
    t.text     "secrets"
    t.datetime "force_update"
    t.text     "username"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.integer  "cornerstonesworld_category_id"
  end

  add_index "cornerstonesworlds", ["business_id"], :name => "index_cornerstonesworlds_on_business_id"

  create_table "coupons", :force => true do |t|
    t.string   "name"
    t.string   "code"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "percentage_off"
    t.integer  "label_id"
  end

  add_index "coupons", ["code"], :name => "index_coupons_on_code"

  create_table "crunchbases", :force => true do |t|
    t.integer  "business_id"
    t.string   "email"
    t.text     "secrets"
    t.datetime "force_update"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "crunchbases", ["business_id"], :name => "index_crunchbases_on_business_id"

  create_table "cylexes", :force => true do |t|
    t.datetime "force_update"
    t.text     "secrets"
    t.integer  "business_id"
    t.string   "email"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "cylexes", ["business_id"], :name => "index_cylexes_on_business_id"

  create_table "digabusiness_categories", :force => true do |t|
    t.integer  "parent_id"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "digabusiness_categories", ["name"], :name => "index_digabusiness_categories_on_name"
  add_index "digabusiness_categories", ["parent_id"], :name => "index_digabusiness_categories_on_parent_id"

  create_table "digabusinesses", :force => true do |t|
    t.integer  "business_id"
    t.text     "secrets"
    t.datetime "force_update"
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
    t.integer  "digabusiness_category_id"
    t.string   "email"
  end

  create_table "discoverourtowns", :force => true do |t|
    t.datetime "force_update"
    t.text     "secrets"
    t.integer  "business_id"
    t.string   "email"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "discoverourtowns", ["business_id"], :name => "index_discoverourtowns_on_business_id"

  create_table "downloads", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "key"
    t.integer  "size"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "downloads", ["user_id"], :name => "index_downloads_on_user_id"

  create_table "ebusinesspage_categories", :force => true do |t|
    t.integer  "parent_id"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "ebusinesspage_categories", ["name"], :name => "index_ebusinesspage_categories_on_name"
  add_index "ebusinesspage_categories", ["parent_id"], :name => "index_ebusinesspage_categories_on_parent_id"

  create_table "ebusinesspages", :force => true do |t|
    t.integer  "business_id"
    t.text     "secrets"
    t.datetime "force_update"
    t.integer  "ebusinesspage_category_id"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
    t.string   "username"
  end

  create_table "expertfocus", :force => true do |t|
    t.integer  "business_id"
    t.string   "expertfocus_category_id"
    t.text     "secrets"
    t.datetime "force_update"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  create_table "expertfocus_categories", :force => true do |t|
    t.integer  "parent_id"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "expertfocus_categories", ["name"], :name => "index_expertfocus_categories_on_name"
  add_index "expertfocus_categories", ["parent_id"], :name => "index_expertfocus_categories_on_parent_id"

  create_table "expressbusinessdirectories", :force => true do |t|
    t.integer  "business_id"
    t.text     "secrets"
    t.datetime "force_update"
    t.text     "username"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "expressbusinessdirectories", ["business_id"], :name => "index_expressbusinessdirectories_on_business_id"

  create_table "expressupdateusas", :force => true do |t|
    t.integer  "business_id"
    t.datetime "force_update"
    t.text     "secrets"
    t.string   "email"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "ezlocal_categories", :force => true do |t|
    t.integer  "parent_id"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "ezlocal_categories", ["name"], :name => "index_ezlocal_categories_on_name"
  add_index "ezlocal_categories", ["parent_id"], :name => "index_ezlocal_categories_on_parent_id"

  create_table "ezlocals", :force => true do |t|
    t.integer  "business_id"
    t.datetime "force_update"
    t.text     "secrets"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.integer  "ezlocal_category_id"
    t.string   "email"
  end

  create_table "facebooks", :force => true do |t|
    t.integer  "business_id"
    t.string   "email"
    t.text     "secrets"
    t.string   "status"
    t.datetime "force_update"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "failed_jobs", :force => true do |t|
    t.integer  "business_id"
    t.string   "name"
    t.text     "data_generator"
    t.integer  "status"
    t.text     "status_message"
    t.text     "payload"
    t.text     "returned"
    t.datetime "waited_at"
    t.integer  "position"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "failed_jobs", ["business_id"], :name => "index_failed_jobs_on_business_id"
  add_index "failed_jobs", ["status"], :name => "index_failed_jobs_on_status"

  create_table "findstorenearus", :force => true do |t|
    t.integer  "business_id"
    t.text     "secrets"
    t.datetime "force_update"
    t.text     "email"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "findstorenearus", ["business_id"], :name => "index_findstorenearus_on_business_id"

  create_table "findthebest_categories", :force => true do |t|
    t.integer  "parent_id"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "findthebest_categories", ["name"], :name => "index_findthebest_categories_on_name"
  add_index "findthebest_categories", ["parent_id"], :name => "index_findthebest_categories_on_parent_id"

  create_table "findthebests", :force => true do |t|
    t.integer  "business_id"
    t.string   "email"
    t.text     "secrets"
    t.datetime "force_update"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
    t.integer  "findthebest_category_id"
  end

  create_table "foursquare_categories", :force => true do |t|
    t.integer  "parent_id"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "foursquare_categories", ["name"], :name => "index_foursquare_categories_on_name"
  add_index "foursquare_categories", ["parent_id"], :name => "index_foursquare_categories_on_parent_id"

  create_table "foursquares", :force => true do |t|
    t.integer  "business_id"
    t.string   "email"
    t.text     "secrets"
    t.string   "status"
    t.boolean  "facebook_signin"
    t.datetime "force_update"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
    t.integer  "foursquare_category_id"
  end

  add_index "foursquares", ["business_id"], :name => "index_foursquares_on_business_id"

  create_table "freebusinessdirectories", :force => true do |t|
    t.integer  "business_id"
    t.text     "secrets"
    t.datetime "force_update"
    t.text     "username"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "freebusinessdirectories", ["business_id"], :name => "index_freebusinessdirectories_on_business_id"

  create_table "getfavs", :force => true do |t|
    t.datetime "force_update"
    t.text     "secrets"
    t.string   "email"
    t.integer  "business_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "getfavs", ["business_id"], :name => "index_getfavs_on_business_id"

  create_table "gomylocal_categories", :force => true do |t|
    t.integer  "parent_id"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "gomylocal_categories", ["name"], :name => "index_gomylocal_categories_on_name"
  add_index "gomylocal_categories", ["parent_id"], :name => "index_gomylocal_categories_on_parent_id"

  create_table "gomylocals", :force => true do |t|
    t.integer  "business_id"
    t.string   "username"
    t.text     "secrets"
    t.datetime "force_update"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
    t.integer  "gomylocal_category_id"
  end

  create_table "google_categories", :force => true do |t|
    t.string   "name"
    t.string   "slug"
    t.integer  "yelp_category_id"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.integer  "yahoo_category_id"
    t.integer  "bing_category_id"
    t.integer  "ezlocal_category_id"
    t.integer  "ebusinesspage_category_id"
    t.integer  "localcensus_category_id"
    t.integer  "yippie_category_id"
    t.integer  "usbdn_category_id"
    t.integer  "yellowassistance_category_id"
    t.integer  "shopinusa_category_id"
    t.integer  "citisquare_category_id"
    t.integer  "shopcity_category_id"
    t.integer  "zippro_category_id"
    t.integer  "yellowee_category_id"
    t.integer  "yellowise_category_id"
    t.integer  "primeplace_category_id"
    t.integer  "digabusiness_category_id"
    t.integer  "supermedia_category_id"
    t.integer  "expertfocus_category_id"
    t.integer  "cornerstoneworld_category_id"
    t.integer  "angies_list_category_id"
    t.integer  "localizedbiz_category_id"
    t.integer  "kudzu_category_id"
    t.integer  "localeze_category_id"
    t.integer  "showmelocal_category_id"
    t.integer  "hyplo_category_id"
    t.integer  "ibegin_category_id"
    t.integer  "insider_page_category_id"
    t.integer  "cornerstonesworld_category_id"
    t.integer  "foursquare_category_id"
    t.integer  "gomylocal_category_id"
    t.integer  "localdatabase_category_id"
    t.integer  "localpages_category_id"
    t.integer  "magicyellow_category_id"
    t.integer  "merchantcircle_category_id"
    t.integer  "mojopages_category_id"
    t.integer  "spotbusiness_category_id"
    t.integer  "staylocal_category_id"
    t.integer  "tupalo_category_id"
    t.integer  "uscity_category_id"
    t.integer  "adsolutionsyp_category_id"
    t.integer  "findthebest_category_id"
    t.integer  "businessdb_category_id"
    t.integer  "patch_category_id"
  end

  add_index "google_categories", ["name"], :name => "index_google_categories_on_name"
  add_index "google_categories", ["slug"], :name => "index_google_categories_on_slug"
  add_index "google_categories", ["yelp_category_id"], :name => "index_google_categories_on_yelp_category_id"

  create_table "googles", :force => true do |t|
    t.integer  "business_id"
    t.string   "email"
    t.string   "youtube_channel"
    t.string   "places_url"
    t.text     "secrets"
    t.string   "status"
    t.datetime "force_update"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.integer  "google_category_id"
  end

  add_index "googles", ["business_id"], :name => "index_googles_on_business_id"

  create_table "hotfrogs", :force => true do |t|
    t.integer  "business_id"
    t.string   "email"
    t.text     "secrets"
    t.string   "status"
    t.datetime "force_update"
    t.string   "listing_url"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "hotfrogs", ["business_id"], :name => "index_hotfrogs_on_business_id"

  create_table "hyplo_categories", :force => true do |t|
    t.integer  "parent_id"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "hyplo_categories", ["name"], :name => "index_hyplo_categories_on_name"
  add_index "hyplo_categories", ["parent_id"], :name => "index_hyplo_categories_on_parent_id"

  create_table "hyplos", :force => true do |t|
    t.integer  "business_id"
    t.text     "secrets"
    t.datetime "force_update"
    t.text     "username"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.integer  "hyplo_category_id"
  end

  add_index "hyplos", ["business_id"], :name => "index_hyplos_on_business_id"

  create_table "ibegin_categories", :force => true do |t|
    t.integer  "parent_id"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "ibegin_categories", ["name"], :name => "index_ibegin_categories_on_name"
  add_index "ibegin_categories", ["parent_id"], :name => "index_ibegin_categories_on_parent_id"

  create_table "ibegins", :force => true do |t|
    t.integer  "business_id"
    t.string   "email"
    t.text     "secrets"
    t.datetime "force_update"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.integer  "ibegin_category_id"
  end

  create_table "images", :force => true do |t|
    t.integer  "business_id"
    t.integer  "position"
    t.string   "file_name"
    t.string   "display_name"
    t.integer  "data_file_size"
    t.string   "data_file_name"
    t.string   "data_content_type"
    t.datetime "data_updated_at"
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  add_index "images", ["business_id"], :name => "index_images_on_business_id"

  create_table "insider_page_categories", :force => true do |t|
    t.integer  "parent_id"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "insider_page_categories", ["name"], :name => "index_insider_page_categories_on_name"
  add_index "insider_page_categories", ["parent_id"], :name => "index_insider_page_categories_on_parent_id"

  create_table "insider_pages", :force => true do |t|
    t.integer  "business_id"
    t.string   "email"
    t.text     "secrets"
    t.string   "listing_url"
    t.boolean  "facebook_signin"
    t.string   "status"
    t.datetime "force_update"
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
    t.integer  "insider_page_category_id"
  end

  add_index "insider_pages", ["business_id"], :name => "index_insider_pages_on_business_id"

  create_table "insiderpages", :force => true do |t|
    t.integer  "business_id"
    t.string   "email"
    t.text     "secrets"
    t.datetime "force_update"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "jaydes", :force => true do |t|
    t.integer  "business_id"
    t.text     "secrets"
    t.datetime "force_update"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "jobs", :force => true do |t|
    t.integer  "business_id"
    t.string   "name"
    t.string   "model"
    t.integer  "status"
    t.text     "status_message"
    t.text     "payload"
    t.text     "returned"
    t.datetime "waited_at"
    t.integer  "position"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.text     "ready"
    t.text     "data_generator"
  end

  add_index "jobs", ["business_id"], :name => "index_jobs_on_business_id"
  add_index "jobs", ["status"], :name => "index_jobs_on_status"

  create_table "judys_books", :force => true do |t|
    t.integer  "business_id"
    t.string   "email"
    t.text     "secrets"
    t.string   "status"
    t.boolean  "facebook_signin"
    t.datetime "force_update"
    t.string   "listing_url"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "judys_books", ["business_id"], :name => "index_judys_books_on_business_id"

  create_table "justclicklocals", :force => true do |t|
    t.integer  "business_id"
    t.text     "secrets"
    t.datetime "force_update"
    t.text     "username"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "justclicklocals", ["business_id"], :name => "index_justclicklocals_on_business_id"

  create_table "kudzu_categories", :force => true do |t|
    t.integer  "parent_id"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "kudzu_categories", ["name"], :name => "index_kudzu_categories_on_name"
  add_index "kudzu_categories", ["parent_id"], :name => "index_kudzu_categories_on_parent_id"

  create_table "kudzus", :force => true do |t|
    t.integer  "business_id"
    t.string   "username"
    t.text     "secrets"
    t.string   "listing_url"
    t.string   "status"
    t.datetime "force_update"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.integer  "kudzu_category_id"
  end

  add_index "kudzus", ["business_id"], :name => "index_kudzus_on_business_id"

  create_table "labels", :force => true do |t|
    t.string   "name"
    t.string   "domain"
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.text     "custom_css"
    t.datetime "created_at",                                                             :null => false
    t.datetime "updated_at",                                                             :null => false
    t.string   "login"
    t.string   "password"
    t.text     "footer"
    t.integer  "parent_id"
    t.integer  "credits",           :default => 0
    t.string   "mail_from",         :default => "change_this@to_your_support_email.com"
  end

  add_index "labels", ["domain"], :name => "index_labels_on_domain"

  create_table "linkedins", :force => true do |t|
    t.integer  "business_id"
    t.string   "email"
    t.text     "secrets"
    t.string   "status"
    t.datetime "force_update"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "linkedins", ["business_id"], :name => "index_linkedins_on_business_id"

  create_table "listwns", :force => true do |t|
    t.integer  "business_id"
    t.text     "secrets"
    t.datetime "force_update"
    t.text     "username"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "listwns", ["business_id"], :name => "index_listwns_on_business_id"

  create_table "localcensus", :force => true do |t|
    t.integer  "business_id"
    t.text     "secrets"
    t.datetime "force_update"
    t.integer  "localcensus_category_id"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  create_table "localcensus_categories", :force => true do |t|
    t.integer  "parent_id"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "localcensus_categories", ["name"], :name => "index_localcensus_categories_on_name"
  add_index "localcensus_categories", ["parent_id"], :name => "index_localcensus_categories_on_parent_id"

  create_table "localcoms", :force => true do |t|
    t.integer  "business_id"
    t.text     "secrets"
    t.datetime "force_update"
    t.text     "username"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "localcoms", ["business_id"], :name => "index_localcoms_on_business_id"

  create_table "localdatabase_categories", :force => true do |t|
    t.integer  "parent_id"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "localdatabase_categories", ["name"], :name => "index_localdatabase_categories_on_name"
  add_index "localdatabase_categories", ["parent_id"], :name => "index_localdatabase_categories_on_parent_id"

  create_table "localdatabases", :force => true do |t|
    t.integer  "business_id"
    t.text     "secrets"
    t.datetime "force_update"
    t.text     "username"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
    t.integer  "localdatabase_category_id"
  end

  create_table "localeze_categories", :force => true do |t|
    t.integer  "parent_id"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "localeze_categories", ["name"], :name => "index_localeze_categories_on_name"
  add_index "localeze_categories", ["parent_id"], :name => "index_localeze_categories_on_parent_id"

  create_table "localezes", :force => true do |t|
    t.integer  "business_id"
    t.integer  "localeze_category_id"
    t.text     "secrets"
    t.datetime "force_update"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
  end

  add_index "localezes", ["business_id"], :name => "index_localezes_on_business_id"

  create_table "localizedbiz_categories", :force => true do |t|
    t.integer  "parent_id"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "localizedbiz_categories", ["name"], :name => "index_localizedbiz_categories_on_name"
  add_index "localizedbiz_categories", ["parent_id"], :name => "index_localizedbiz_categories_on_parent_id"

  create_table "localizedbizs", :force => true do |t|
    t.integer  "business_id"
    t.text     "secrets"
    t.datetime "force_update"
    t.text     "username"
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
    t.integer  "localizedbiz_category_id"
  end

  add_index "localizedbizs", ["business_id"], :name => "index_localizedbizs_on_business_id"

  create_table "localndexes", :force => true do |t|
    t.integer  "business_id"
    t.text     "secrets"
    t.datetime "force_update"
    t.text     "username"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "localndexes", ["business_id"], :name => "index_localndexes_on_business_id"

  create_table "localpages", :force => true do |t|
    t.integer  "business_id"
    t.text     "secrets"
    t.datetime "force_update"
    t.text     "username"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
    t.integer  "localpages_category_id"
  end

  add_index "localpages", ["business_id"], :name => "index_localpages_on_business_id"

  create_table "localpages_categories", :force => true do |t|
    t.integer  "parent_id"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "localpages_categories", ["name"], :name => "index_localpages_categories_on_name"
  add_index "localpages_categories", ["parent_id"], :name => "index_localpages_categories_on_parent_id"

  create_table "locations", :force => true do |t|
    t.string   "zip",                                        :null => false
    t.string   "city"
    t.string   "county"
    t.string   "state"
    t.string   "country"
    t.decimal  "latitude",   :precision => 15, :scale => 10
    t.decimal  "longitude",  :precision => 15, :scale => 10
    t.string   "metaphone"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "magicyellow_categories", :force => true do |t|
    t.integer  "parent_id"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "magicyellow_categories", ["name"], :name => "index_magicyellow_categories_on_name"
  add_index "magicyellow_categories", ["parent_id"], :name => "index_magicyellow_categories_on_parent_id"

  create_table "magicyellows", :force => true do |t|
    t.datetime "force_update"
    t.integer  "business_id"
    t.string   "email"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
    t.integer  "magicyellow_category_id"
    t.text     "secrets"
  end

  add_index "magicyellows", ["business_id"], :name => "index_magicyellows_on_business_id"

  create_table "manta", :force => true do |t|
    t.integer  "business_id"
    t.text     "secrets"
    t.datetime "force_update"
    t.string   "email"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "manta", ["business_id"], :name => "index_manta_on_business_id"

  create_table "map_quests", :force => true do |t|
    t.integer  "business_id"
    t.string   "email"
    t.text     "secrets"
    t.string   "status"
    t.datetime "force_update"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "map_quests", ["business_id"], :name => "index_map_quests_on_business_id"

  create_table "matchpoint_categories", :force => true do |t|
    t.integer  "parent_id"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "matchpoint_categories", ["name"], :name => "index_matchpoint_categories_on_name"
  add_index "matchpoint_categories", ["parent_id"], :name => "index_matchpoint_categories_on_parent_id"

  create_table "matchpoints", :force => true do |t|
    t.integer  "business_id"
    t.text     "secrets"
    t.datetime "force_update"
    t.text     "username"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "matchpoints", ["business_id"], :name => "index_matchpoints_on_business_id"

  create_table "merchantcircle_categories", :force => true do |t|
    t.integer  "parent_id"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "merchantcircle_categories", ["name"], :name => "index_merchantcircle_categories_on_name"
  add_index "merchantcircle_categories", ["parent_id"], :name => "index_merchantcircle_categories_on_parent_id"

  create_table "merchantcircles", :force => true do |t|
    t.datetime "force_update"
    t.text     "secrets"
    t.integer  "business_id"
    t.string   "email"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
    t.integer  "merchantcircle_category_id"
  end

  add_index "merchantcircles", ["business_id"], :name => "index_merchantcircles_on_business_id"

  create_table "mojopages", :force => true do |t|
    t.datetime "force_update"
    t.text     "secrets"
    t.integer  "business_id"
    t.string   "email"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
    t.integer  "mojopages_category_id"
  end

  add_index "mojopages", ["business_id"], :name => "index_mojopages_on_business_id"

  create_table "mojopages_categories", :force => true do |t|
    t.integer  "parent_id"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "mojopages_categories", ["name"], :name => "index_mojopages_categories_on_name"
  add_index "mojopages_categories", ["parent_id"], :name => "index_mojopages_categories_on_parent_id"

  create_table "mycitybusinesses", :force => true do |t|
    t.integer  "business_id"
    t.text     "secrets"
    t.datetime "force_update"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "mycitybusinesses", ["business_id"], :name => "index_mycitybusinesses_on_business_id"

  create_table "mydestinations", :force => true do |t|
    t.datetime "force_update"
    t.integer  "business_id"
    t.string   "email"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "mydestinations", ["business_id"], :name => "index_mydestinations_on_business_id"

  create_table "notifications", :force => true do |t|
    t.integer  "business_id"
    t.string   "title"
    t.text     "body"
    t.string   "url"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "notifications", ["business_id"], :name => "index_notifications_on_business_id"

  create_table "package_payloads", :force => true do |t|
    t.integer  "package_id"
    t.string   "site"
    t.string   "payload"
    t.string   "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "package_payloads", ["package_id"], :name => "index_packages_payloads_on_package_id"
  add_index "package_payloads", ["payload"], :name => "index_packages_payloads_on_payload"
  add_index "package_payloads", ["site"], :name => "index_packages_payloads_on_site"

  create_table "packages", :force => true do |t|
    t.string   "name"
    t.integer  "price"
    t.text     "description"
    t.text     "short_description"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.integer  "monthly_fee"
    t.integer  "label_id"
  end

  create_table "patch_categories", :force => true do |t|
    t.integer  "parent_id"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "patch_categories", ["name"], :name => "index_patch_categories_on_name"
  add_index "patch_categories", ["parent_id"], :name => "index_patch_categories_on_parent_id"

  create_table "patches", :force => true do |t|
    t.integer  "business_id"
    t.string   "email"
    t.text     "secrets"
    t.datetime "force_update"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.integer  "patch_category_id"
  end

  create_table "payments", :force => true do |t|
    t.string   "status"
    t.string   "name"
    t.integer  "amount"
    t.string   "transaction_number"
    t.integer  "business_id"
    t.integer  "label_id"
    t.integer  "transaction_event_id"
    t.string   "message"
    t.text     "response"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
  end

  add_index "payments", ["business_id"], :name => "index_payments_on_business_id"
  add_index "payments", ["label_id"], :name => "index_payments_on_label_id"
  add_index "payments", ["transaction_event_id"], :name => "index_payments_on_transaction_id"

  create_table "primeplace_categories", :force => true do |t|
    t.integer  "parent_id"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "primeplace_categories", ["name"], :name => "index_primeplace_categories_on_name"
  add_index "primeplace_categories", ["parent_id"], :name => "index_primeplace_categories_on_parent_id"

  create_table "primeplaces", :force => true do |t|
    t.integer  "business_id"
    t.text     "secrets"
    t.datetime "force_update"
    t.text     "username"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
    t.integer  "primeplace_category_id"
  end

  add_index "primeplaces", ["business_id"], :name => "index_primeplaces_on_business_id"

  create_table "rookies", :force => true do |t|
    t.integer  "position"
    t.string   "name"
    t.text     "payload"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "searches", :force => true do |t|
    t.string   "name"
    t.string   "zip"
    t.string   "address"
    t.string   "phone"
    t.string   "city"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "shopcities", :force => true do |t|
    t.integer  "business_id"
    t.text     "secrets"
    t.datetime "force_update"
    t.text     "username"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
    t.integer  "shopcity_category_id"
  end

  add_index "shopcities", ["business_id"], :name => "index_shopcities_on_business_id"

  create_table "shopcity_categories", :force => true do |t|
    t.integer  "parent_id"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "shopcity_categories", ["name"], :name => "index_shopcity_categories_on_name"
  add_index "shopcity_categories", ["parent_id"], :name => "index_shopcity_categories_on_parent_id"

  create_table "shopinusa_categories", :force => true do |t|
    t.integer  "parent_id"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "shopinusa_categories", ["name"], :name => "index_shopinusa_categories_on_name"
  add_index "shopinusa_categories", ["parent_id"], :name => "index_shopinusa_categories_on_parent_id"

  create_table "shopinusas", :force => true do |t|
    t.integer  "business_id"
    t.text     "secrets"
    t.datetime "force_update"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
    t.integer  "shopinusa_category_id"
  end

  add_index "shopinusas", ["business_id"], :name => "index_shopinusas_on_business_id"

  create_table "showmelocal_categories", :force => true do |t|
    t.integer  "parent_id"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "showmelocal_categories", ["name"], :name => "index_showmelocal_categories_on_name"
  add_index "showmelocal_categories", ["parent_id"], :name => "index_showmelocal_categories_on_parent_id"

  create_table "showmelocals", :force => true do |t|
    t.integer  "business_id"
    t.text     "secrets"
    t.datetime "force_update"
    t.text     "username"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
    t.integer  "showmelocal_category_id"
  end

  add_index "showmelocals", ["business_id"], :name => "index_showmelocals_on_business_id"

  create_table "snoopitnow_categories", :force => true do |t|
    t.integer  "parent_id"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "snoopitnows", :force => true do |t|
    t.integer  "business_id"
    t.string   "snoopitnow_category_id"
    t.text     "secrets"
    t.datetime "force_update"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
  end

  create_table "spotbusiness_categories", :force => true do |t|
    t.integer  "parent_id"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "spotbusiness_categories", ["name"], :name => "index_spotbusiness_categories_on_name"
  add_index "spotbusiness_categories", ["parent_id"], :name => "index_spotbusiness_categories_on_parent_id"

  create_table "spotbusinesses", :force => true do |t|
    t.datetime "force_update"
    t.text     "secrets"
    t.integer  "business_id"
    t.string   "email"
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
    t.integer  "spotbusiness_category_id"
  end

  add_index "spotbusinesses", ["business_id"], :name => "index_spotbusinesses_on_business_id"

  create_table "staylocal_categories", :force => true do |t|
    t.integer  "parent_id"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "staylocal_categories", ["name"], :name => "index_staylocal_categories_on_name"
  add_index "staylocal_categories", ["parent_id"], :name => "index_staylocal_categories_on_parent_id"

  create_table "staylocals", :force => true do |t|
    t.datetime "force_update"
    t.text     "secrets"
    t.integer  "business_id"
    t.string   "email"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
    t.integer  "staylocal_category_id"
  end

  add_index "staylocals", ["business_id"], :name => "index_staylocals_on_business_id"

  create_table "subscriptions", :force => true do |t|
    t.integer  "package_id"
    t.boolean  "tos_agreed"
    t.boolean  "active"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
    t.integer  "intial_fee"
    t.string   "subscription_code"
    t.integer  "label_id"
    t.integer  "business_id"
    t.text     "response"
    t.string   "message"
    t.integer  "monthly_fee"
    t.string   "status"
    t.integer  "transaction_event_id"
  end

  add_index "subscriptions", ["package_id"], :name => "index_subscriptions_on_package_id"

  create_table "supermedia", :force => true do |t|
    t.integer  "business_id"
    t.text     "secrets"
    t.datetime "force_update"
    t.text     "username"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "supermedia", ["business_id"], :name => "index_supermedia_on_business_id"

  create_table "supermedia_categories", :force => true do |t|
    t.integer  "parent_id"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "supermedia_categories", ["name"], :name => "index_supermedia_categories_on_name"
  add_index "supermedia_categories", ["parent_id"], :name => "index_supermedia_categories_on_parent_id"

  create_table "superpages", :force => true do |t|
    t.integer  "business_id"
    t.datetime "force_update"
    t.text     "secrets"
    t.string   "email"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "superpages", ["business_id"], :name => "index_superpages_on_business_id"

  create_table "tasks", :force => true do |t|
    t.integer  "business_id"
    t.datetime "started_at"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "tasks", ["business_id"], :name => "index_tasks_on_business_id"

  create_table "thumbtacks", :force => true do |t|
    t.integer  "business_id"
    t.datetime "force_update"
    t.text     "secrets"
    t.string   "email"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "thumbtacks", ["business_id"], :name => "index_thumbtacks_on_business_id"

  create_table "transaction_events", :force => true do |t|
    t.integer  "subscription_id"
    t.integer  "payment_id"
    t.string   "status"
    t.integer  "business_id"
    t.integer  "label_id"
    t.integer  "coupon_id"
    t.integer  "package_id"
    t.integer  "price"
    t.integer  "original_price"
    t.integer  "monthly_fee"
    t.integer  "saved"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "message"
  end

  add_index "transaction_events", ["business_id"], :name => "index_transactions_on_business_id"
  add_index "transaction_events", ["coupon_id"], :name => "index_transactions_on_coupon_id"
  add_index "transaction_events", ["label_id"], :name => "index_transactions_on_label_id"
  add_index "transaction_events", ["package_id"], :name => "index_transactions_on_package_id"
  add_index "transaction_events", ["payment_id"], :name => "index_transactions_on_payment_id"
  add_index "transaction_events", ["subscription_id"], :name => "index_transactions_on_subscription_id"

  create_table "tupalo_categories", :force => true do |t|
    t.integer  "parent_id"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "tupalo_categories", ["name"], :name => "index_tupalo_categories_on_name"
  add_index "tupalo_categories", ["parent_id"], :name => "index_tupalo_categories_on_parent_id"

  create_table "tupalos", :force => true do |t|
    t.integer  "business_id"
    t.text     "secrets"
    t.datetime "force_update"
    t.text     "username"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.integer  "tupalo_category_id"
  end

  create_table "tweets", :force => true do |t|
    t.integer  "business_id"
    t.string   "message"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "tweets", ["business_id"], :name => "index_tweets_on_business_id"

  create_table "twitters", :force => true do |t|
    t.integer  "business_id"
    t.string   "username"
    t.text     "secrets"
    t.string   "status"
    t.datetime "force_update"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "usbdn_categories", :force => true do |t|
    t.integer  "parent_id"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "usbdn_categories", ["name"], :name => "index_usbdn_categories_on_name"
  add_index "usbdn_categories", ["parent_id"], :name => "index_usbdn_categories_on_parent_id"

  create_table "usbdns", :force => true do |t|
    t.integer  "business_id"
    t.text     "secrets"
    t.datetime "force_update"
    t.text     "username"
    t.integer  "usbdn_category_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  add_index "usbdns", ["business_id"], :name => "index_usbdns_on_business_id"

  create_table "uscities", :force => true do |t|
    t.datetime "force_update"
    t.text     "secrets"
    t.integer  "business_id"
    t.string   "email"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.integer  "uscity_category_id"
    t.text     "secret_answer"
  end

  add_index "uscities", ["business_id"], :name => "index_uscities_on_business_id"

  create_table "uscity_categories", :force => true do |t|
    t.integer  "parent_id"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "uscity_categories", ["name"], :name => "index_uscity_categories_on_name"
  add_index "uscity_categories", ["parent_id"], :name => "index_uscity_categories_on_parent_id"

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "",        :null => false
    t.string   "encrypted_password",     :default => "",        :null => false
    t.integer  "access_level",           :default => 116390000, :null => false
    t.integer  "parent_id"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "authentication_token"
    t.datetime "created_at",                                    :null => false
    t.datetime "updated_at",                                    :null => false
    t.integer  "label_id"
    t.boolean  "callcenter"
  end

  add_index "users", ["authentication_token"], :name => "index_users_on_authentication_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["label_id"], :name => "index_users_on_label_id"
  add_index "users", ["parent_id"], :name => "index_users_on_parent_id"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "yahoo_categories", :force => true do |t|
    t.integer  "rcatid"
    t.string   "catname"
    t.integer  "subcatid"
    t.string   "subcatname"
    t.boolean  "subprofcontact"
    t.string   "synonyms"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "yahoos", :force => true do |t|
    t.integer  "business_id"
    t.integer  "yahoo_category_id"
    t.string   "email"
    t.text     "secrets"
    t.datetime "force_update"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  add_index "yahoos", ["business_id"], :name => "index_yahoos_on_business_id"
  add_index "yahoos", ["email"], :name => "index_yahoos_on_email"
  add_index "yahoos", ["yahoo_category_id"], :name => "index_yahoos_on_yahoo_category_id"

  create_table "yellow_bots", :force => true do |t|
    t.string   "username"
    t.string   "email"
    t.datetime "force_update"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.text     "secrets"
    t.integer  "business_id"
  end

  create_table "yellowassistance_categories", :force => true do |t|
    t.integer  "parent_id"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "yellowassistance_categories", ["name"], :name => "index_yellowassistance_categories_on_name"
  add_index "yellowassistance_categories", ["parent_id"], :name => "index_yellowassistance_categories_on_parent_id"

  create_table "yellowassistances", :force => true do |t|
    t.integer  "business_id"
    t.text     "secrets"
    t.datetime "force_update"
    t.text     "username"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
    t.integer  "yellowassistance_category_id"
    t.text     "secret_answer"
  end

  add_index "yellowassistances", ["business_id"], :name => "index_yellowassistances_on_business_id"

  create_table "yellowee_categories", :force => true do |t|
    t.integer  "parent_id"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "yellowee_categories", ["name"], :name => "index_yellowee_categories_on_name"
  add_index "yellowee_categories", ["parent_id"], :name => "index_yellowee_categories_on_parent_id"

  create_table "yellowees", :force => true do |t|
    t.integer  "business_id"
    t.text     "secrets"
    t.datetime "force_update"
    t.text     "username"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
    t.integer  "yellowee_category_id"
  end

  add_index "yellowees", ["business_id"], :name => "index_yellowees_on_business_id"

  create_table "yellowise_categories", :force => true do |t|
    t.integer  "parent_id"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "yellowise_categories", ["name"], :name => "index_yellowise_categories_on_name"
  add_index "yellowise_categories", ["parent_id"], :name => "index_yellowise_categories_on_parent_id"

  create_table "yellowises", :force => true do |t|
    t.integer  "business_id"
    t.text     "secrets"
    t.datetime "force_update"
    t.text     "username"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
    t.integer  "yellowise_category_id"
  end

  add_index "yellowises", ["business_id"], :name => "index_yellowises_on_business_id"

  create_table "yelp_categories", :force => true do |t|
    t.integer  "parent_id"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "yelp_categories", ["parent_id"], :name => "index_yelp_categories_on_parent_id"

  create_table "yelps", :force => true do |t|
    t.integer  "business_id"
    t.integer  "yelp_category_id"
    t.string   "email"
    t.text     "secrets"
    t.string   "status"
    t.datetime "force_update"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "yelps", ["business_id"], :name => "index_yelps_on_business_id"

  create_table "yippie_categories", :force => true do |t|
    t.integer  "parent_id"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "yippie_categories", ["name"], :name => "index_yippie_categories_on_name"
  add_index "yippie_categories", ["parent_id"], :name => "index_yippie_categories_on_parent_id"

  create_table "yippies", :force => true do |t|
    t.integer  "business_id"
    t.text     "secrets"
    t.datetime "force_update"
    t.integer  "yippie_category_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

create_table "zipperpages", :force => true do |t|
    t.integer "business_id"
    t.string "email"
    t.text "secrets"
    t.datetime "force_update"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "zippro_categories", :force => true do |t|
    t.integer  "parent_id"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "zippro_categories", ["name"], :name => "index_zippro_categories_on_name"
  add_index "zippro_categories", ["parent_id"], :name => "index_zippro_categories_on_parent_id"

  create_table "zippros", :force => true do |t|
    t.integer  "business_id"
    t.text     "secrets"
    t.datetime "force_update"
    t.text     "username"
    t.text     "secret1"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.integer  "zippro_category2_id"
    t.integer  "zippro_category_id"
    t.integer  "form_id"
  end

  add_index "zippros", ["business_id"], :name => "index_zippros_on_business_id"

end
