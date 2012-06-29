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

ActiveRecord::Schema.define(:version => 20120629225043) do

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
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
  end

  add_index "admin_users", ["email"], :name => "index_admin_users_on_email", :unique => true
  add_index "admin_users", ["reset_password_token"], :name => "index_admin_users_on_reset_password_token", :unique => true

  create_table "angies_lists", :force => true do |t|
    t.integer  "business_id"
    t.string   "email"
    t.text     "secrets"
    t.string   "status"
    t.datetime "force_update"
    t.string   "listing_url"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "angies_lists", ["business_id"], :name => "index_angies_lists_on_business_id"

  create_table "bings", :force => true do |t|
    t.integer  "business_id"
    t.string   "local_url"
    t.string   "email"
    t.text     "secrets"
    t.string   "status"
    t.datetime "force_update"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
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

  create_table "businesses", :force => true do |t|
    t.integer  "user_id"
    t.string   "business_name"
    t.string   "corporate_name"
    t.string   "duns_number"
    t.string   "sic_code"
    t.string   "contact_gender"
    t.string   "contact_prefix"
    t.string   "contact_first_name"
    t.string   "contact_middle_name"
    t.string   "contact_last_name"
    t.string   "company_email"
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
    t.text     "languages"
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
    t.string   "services_offered"
    t.string   "specialies"
    t.string   "professional_associations"
    t.string   "geographic_areas"
    t.string   "year_founded"
    t.string   "company_website"
    t.string   "incentive_offers"
    t.string   "links_to_photos"
    t.string   "links_to_videos"
    t.string   "fan_page_url"
    t.text     "other_social_links"
    t.text     "positive_review_links"
    t.string   "keyword1"
    t.string   "keyword2"
    t.string   "keyword3"
    t.string   "keyword4"
    t.string   "keyword5"
    t.text     "competitors"
    t.string   "most_like"
    t.string   "industry_leaders"
    t.string   "mail_host"
    t.integer  "mail_port"
    t.string   "mail_username"
    t.text     "mail_password"
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
    t.datetime "client_checkin"
  end

  add_index "businesses", ["user_id"], :name => "index_businesses_on_user_id"

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
    t.integer  "user_id"
    t.string   "name"
    t.string   "model"
    t.integer  "status"
    t.string   "status_message"
    t.text     "payload"
    t.text     "returned"
    t.boolean  "wait"
    t.datetime "waited_at"
    t.integer  "position"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "completed_jobs", ["status"], :name => "index_completed_jobs_on_status"
  add_index "completed_jobs", ["user_id"], :name => "index_completed_jobs_on_user_id"

  create_table "downloads", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "key"
    t.integer  "size"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "downloads", ["user_id"], :name => "index_downloads_on_user_id"

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
    t.integer  "user_id"
    t.string   "name"
    t.string   "model"
    t.integer  "status"
    t.string   "status_message"
    t.text     "payload"
    t.text     "returned"
    t.boolean  "wait"
    t.datetime "waited_at"
    t.integer  "position"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "failed_jobs", ["status"], :name => "index_failed_jobs_on_status"
  add_index "failed_jobs", ["user_id"], :name => "index_failed_jobs_on_user_id"

  create_table "foursquares", :force => true do |t|
    t.integer  "business_id"
    t.string   "email"
    t.text     "secrets"
    t.string   "status"
    t.boolean  "facebook_signin"
    t.datetime "force_update"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "foursquares", ["business_id"], :name => "index_foursquares_on_business_id"

  create_table "googles", :force => true do |t|
    t.integer  "business_id"
    t.string   "email"
    t.string   "youtube_channel"
    t.string   "places_url"
    t.text     "secrets"
    t.string   "status"
    t.datetime "force_update"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
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

  create_table "insider_pages", :force => true do |t|
    t.integer  "business_id"
    t.string   "email"
    t.text     "secrets"
    t.string   "listing_url"
    t.boolean  "facebook_signin"
    t.string   "status"
    t.datetime "force_update"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "insider_pages", ["business_id"], :name => "index_insider_pages_on_business_id"

  create_table "jobs", :force => true do |t|
    t.integer  "business_id"
    t.string   "name"
    t.string   "model"
    t.integer  "status"
    t.string   "status_message"
    t.text     "payload"
    t.text     "returned"
    t.boolean  "wait"
    t.datetime "waited_at"
    t.integer  "position"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.text     "data"
  end

  add_index "jobs", ["business_id"], :name => "index_jobs_on_user_id"
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

  create_table "kudzus", :force => true do |t|
    t.integer  "business_id"
    t.string   "username"
    t.text     "secrets"
    t.string   "listing_url"
    t.string   "status"
    t.datetime "force_update"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "kudzus", ["business_id"], :name => "index_kudzus_on_business_id"

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

  create_table "pings", :force => true do |t|
    t.integer  "user_id"
    t.integer  "business_id"
    t.string   "message"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "pings", ["business_id"], :name => "index_pings_on_business_id"
  add_index "pings", ["user_id"], :name => "index_pings_on_user_id"

  create_table "results", :force => true do |t|
    t.integer  "job_id"
    t.string   "status"
    t.string   "message"
    t.text     "output"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "results", ["job_id"], :name => "index_results_on_job_id"
  add_index "results", ["status"], :name => "index_results_on_status"

  create_table "rookies", :force => true do |t|
    t.integer  "position"
    t.string   "name"
    t.text     "payload"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "tasks", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "tasks", ["name"], :name => "index_tasks_on_name"
  add_index "tasks", ["user_id"], :name => "index_tasks_on_user_id"

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
  end

  add_index "users", ["authentication_token"], :name => "index_users_on_authentication_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["parent_id"], :name => "index_users_on_parent_id"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

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

end
