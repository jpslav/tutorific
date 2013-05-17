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

ActiveRecord::Schema.define(:version => 20130517040154) do

  create_table "cohorts", :force => true do |t|
    t.integer  "section_id"
    t.integer  "number"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "klass_id",   :null => false
    t.string   "name"
  end

  add_index "cohorts", ["klass_id"], :name => "index_cohorts_on_klass_id"
  add_index "cohorts", ["number", "klass_id"], :name => "index_cohorts_on_number_scoped", :unique => true
  add_index "cohorts", ["section_id"], :name => "index_cohorts_on_section_id"

  create_table "courses", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "typically_offered"
    t.integer  "organization_id",   :null => false
    t.integer  "number"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.string   "short_name"
  end

  add_index "courses", ["name", "organization_id"], :name => "index_courses_on_name_scoped", :unique => true
  add_index "courses", ["number", "organization_id"], :name => "index_courses_on_number_scoped", :unique => true
  add_index "courses", ["organization_id"], :name => "index_courses_on_organization_id"

  create_table "educators", :force => true do |t|
    t.integer  "klass_id",              :null => false
    t.integer  "user_id",               :null => false
    t.boolean  "is_instructor"
    t.boolean  "is_teaching_assistant"
    t.boolean  "is_grader"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
  end

  add_index "educators", ["klass_id"], :name => "index_educators_on_klass_id"
  add_index "educators", ["user_id", "klass_id"], :name => "index_educators_on_user_id_scoped", :unique => true
  add_index "educators", ["user_id"], :name => "index_educators_on_user_id"

  create_table "klasses", :force => true do |t|
    t.integer  "course_id"
    t.text     "approved_emails"
    t.datetime "start_date"
    t.datetime "end_date"
    t.string   "time_zone"
    t.datetime "created_at",                                    :null => false
    t.datetime "updated_at",                                    :null => false
    t.boolean  "is_controlled_experiment",   :default => false, :null => false
    t.boolean  "allow_student_specified_id", :default => false, :null => false
    t.datetime "open_date"
    t.datetime "close_date"
  end

  add_index "klasses", ["course_id"], :name => "index_klasses_on_course_id"

  create_table "organizations", :force => true do |t|
    t.string   "name"
    t.string   "default_time_zone"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  add_index "organizations", ["name"], :name => "index_organizations_on_name", :unique => true

  create_table "registration_requests", :force => true do |t|
    t.integer  "user_id",                            :null => false
    t.integer  "section_id",                         :null => false
    t.boolean  "is_auditing",                        :null => false
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.string   "student_specified_id", :limit => 30
  end

  add_index "registration_requests", ["section_id", "user_id"], :name => "index_registration_requests_on_section_id_scoped", :unique => true
  add_index "registration_requests", ["section_id"], :name => "index_registration_requests_on_section_id"
  add_index "registration_requests", ["user_id"], :name => "index_registration_requests_on_user_id"

  create_table "researchers", :force => true do |t|
    t.integer  "user_id",    :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "researchers", ["user_id"], :name => "index_researchers_on_user_id", :unique => true

  create_table "sections", :force => true do |t|
    t.integer  "klass_id",   :null => false
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "sections", ["klass_id"], :name => "index_sections_on_klass_id"
  add_index "sections", ["name", "klass_id"], :name => "index_sections_on_name_scoped", :unique => true

  create_table "students", :force => true do |t|
    t.integer  "cohort_id"
    t.integer  "section_id",                                            :null => false
    t.integer  "user_id",                                               :null => false
    t.boolean  "is_auditing"
    t.datetime "created_at",                                            :null => false
    t.datetime "updated_at",                                            :null => false
    t.string   "student_specified_id", :limit => 30
    t.boolean  "has_dropped",                        :default => false, :null => false
    t.boolean  "is_pending",                         :default => true,  :null => false
  end

  add_index "students", ["cohort_id"], :name => "index_students_on_cohort_id"
  add_index "students", ["section_id"], :name => "index_students_on_section_id"
  add_index "students", ["user_id", "cohort_id"], :name => "index_students_on_user_id_scoped", :unique => true
  add_index "students", ["user_id"], :name => "index_students_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "email",                                                                          :null => false
    t.string   "encrypted_password",                   :default => "",                           :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                        :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",                      :default => 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "username",                                                                       :null => false
    t.datetime "disabled_at"
    t.string   "first_name"
    t.string   "last_name"
    t.boolean  "is_administrator",                     :default => false,                        :null => false
    t.string   "research_id",                                                                    :null => false
    t.string   "education_id",                                                                   :null => false
    t.string   "nickname"
    t.datetime "created_at",                                                                     :null => false
    t.datetime "updated_at",                                                                     :null => false
    t.string   "time_zone",              :limit => 40, :default => "Central Time (US & Canada)", :null => false
    t.boolean  "receives_error_notices"
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["education_id"], :name => "index_users_on_education_id", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["research_id"], :name => "index_users_on_research_id", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["unlock_token"], :name => "index_users_on_unlock_token", :unique => true
  add_index "users", ["username"], :name => "index_users_on_username", :unique => true

end
