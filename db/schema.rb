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

ActiveRecord::Schema.define(:version => 20120727121746) do

  create_table "admins", :force => true do |t|
    t.string   "first_name",             :default => "", :null => false
    t.string   "last_name",              :default => "", :null => false
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
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "admins", ["email"], :name => "index_admins_on_email", :unique => true
  add_index "admins", ["reset_password_token"], :name => "index_admins_on_reset_password_token", :unique => true

  create_table "comments", :force => true do |t|
    t.string   "title",            :limit => 50, :default => ""
    t.text     "comment"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.integer  "user_id"
    t.datetime "created_at",                                     :null => false
    t.datetime "updated_at",                                     :null => false
  end

  add_index "comments", ["commentable_id"], :name => "index_comments_on_commentable_id"
  add_index "comments", ["commentable_type"], :name => "index_comments_on_commentable_type"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "eat_alones", :force => true do |t|
    t.boolean "eat_alone",  :default => true, :null => false
    t.integer "user_id"
    t.date    "created_at"
    t.date    "updated_at"
  end

  create_table "events", :force => true do |t|
    t.string   "name"
    t.datetime "start_at"
    t.datetime "end_at"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "favourites", :force => true do |t|
    t.integer "users_id"
    t.integer "restaurants_id"
  end

  create_table "groups", :force => true do |t|
    t.string  "name"
    t.string  "group_type"
    t.integer "user_id"
  end

  create_table "intervals", :force => true do |t|
    t.string  "day"
    t.string  "interval_type"
    t.boolean "closed"
    t.time    "from"
    t.time    "to"
    t.integer "restaurant_id"
  end

  create_table "ratings", :force => true do |t|
    t.decimal "quality_food"
    t.decimal "quality_service"
    t.decimal "ambience"
    t.decimal "quantity"
    t.decimal "waiting"
    t.integer "user_id"
    t.integer "restaurant_id"
  end

  create_table "restaurants", :force => true do |t|
    t.string  "name"
    t.string  "restaurant_type"
    t.string  "speciality"
    t.string  "picture"
    t.text    "description"
    t.decimal "budget_min"
    t.decimal "budget_max"
    t.integer "time_to_go"
    t.string  "address"
    t.float   "longitude"
    t.float   "latitude"
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "roles", ["name", "resource_type", "resource_id"], :name => "index_roles_on_name_and_resource_type_and_resource_id"
  add_index "roles", ["name"], :name => "index_roles_on_name"

  create_table "rs_evaluations", :force => true do |t|
    t.string  "reputation_name"
    t.integer "source_id"
    t.string  "source_type"
    t.integer "target_id"
    t.string  "target_type"
    t.float   "value",           :default => 0.0
    t.date    "created_at",                       :null => false
    t.date    "updated_at",                       :null => false
  end

  add_index "rs_evaluations", ["reputation_name", "source_id", "source_type", "target_id", "target_type"], :name => "index_rs_evaluations_on_reputation_name_and_source_and_target"
  add_index "rs_evaluations", ["reputation_name"], :name => "index_rs_evaluations_on_reputation_name"
  add_index "rs_evaluations", ["source_id", "source_type"], :name => "index_rs_evaluations_on_source_id_and_source_type"
  add_index "rs_evaluations", ["target_id", "target_type"], :name => "index_rs_evaluations_on_target_id_and_target_type"

  create_table "rs_reputation_messages", :force => true do |t|
    t.integer "sender_id"
    t.string  "sender_type"
    t.integer "receiver_id"
    t.float   "weight",      :default => 1.0
    t.date    "created_at",                   :null => false
    t.date    "updated_at",                   :null => false
  end

  add_index "rs_reputation_messages", ["receiver_id", "sender_id", "sender_type"], :name => "index_rs_reputation_messages_on_receiver_id_and_sender"
  add_index "rs_reputation_messages", ["receiver_id"], :name => "index_rs_reputation_messages_on_receiver_id"
  add_index "rs_reputation_messages", ["sender_id", "sender_type"], :name => "index_rs_reputation_messages_on_sender_id_and_sender_type"

  create_table "rs_reputations", :force => true do |t|
    t.string  "reputation_name"
    t.float   "value",           :default => 0.0
    t.string  "aggregated_by"
    t.integer "target_id"
    t.string  "target_type"
    t.boolean "active",          :default => true
    t.date    "created_at",                        :null => false
    t.date    "updated_at",                        :null => false
  end

  add_index "rs_reputations", ["reputation_name", "target_id", "target_type"], :name => "index_rs_reputations_on_reputation_name_and_target"
  add_index "rs_reputations", ["reputation_name"], :name => "index_rs_reputations_on_reputation_name"
  add_index "rs_reputations", ["target_id", "target_type"], :name => "index_rs_reputations_on_target_id_and_target_type"

  create_table "sondages", :force => true do |t|
    t.string   "name"
    t.datetime "start_at"
    t.datetime "end_at"
    t.datetime "reminder_at"
    t.integer  "event_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "first_name",             :default => "", :null => false
    t.string   "last_name",              :default => "", :null => false
    t.string   "login",                  :default => "", :null => false
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
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["login"], :name => "index_users_on_login", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "users_groups", :force => true do |t|
    t.integer "user_id"
    t.integer "group_id"
  end

  create_table "users_roles", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], :name => "index_users_roles_on_user_id_and_role_id"

  create_table "votes", :force => true do |t|
    t.integer "votable_id"
    t.string  "votable_type"
    t.integer "voter_id"
    t.string  "voter_type"
    t.boolean "vote_flag"
    t.date    "created_at"
    t.date    "updated_at"
  end

end
