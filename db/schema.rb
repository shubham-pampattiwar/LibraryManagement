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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_10_09_210439) do

  create_table "admins", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email"
    t.string "password"
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "book_issue_histories", force: :cascade do |t|
    t.date "issue_date"
    t.date "return_date"
    t.date "overdue_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "student_id"
    t.integer "library_id"
    t.integer "book_id"
    t.index ["book_id"], name: "index_book_issue_histories_on_book_id"
    t.index ["library_id"], name: "index_book_issue_histories_on_library_id"
    t.index ["student_id"], name: "index_book_issue_histories_on_student_id"
  end

  create_table "bookmarks", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "student_id"
    t.integer "book_id"
    t.index ["book_id"], name: "index_bookmarks_on_book_id"
    t.index ["student_id"], name: "index_bookmarks_on_student_id"
  end

  create_table "books", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "isbn"
    t.string "author"
    t.string "language"
    t.date "published"
    t.integer "edition"
    t.string "cover_image"
    t.string "subject"
    t.text "summary"
    t.boolean "special_collection"
    t.integer "quantity"
    t.integer "library_id"
    t.index ["library_id"], name: "index_books_on_library_id"
  end

  create_table "hold_requests", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "student_id"
    t.integer "book_id"
    t.integer "queuenumber"
    t.boolean "approved", default: false, null: false
    t.index ["approved"], name: "index_hold_requests_on_approved"
    t.index ["book_id"], name: "index_hold_requests_on_book_id"
    t.index ["student_id"], name: "index_hold_requests_on_student_id"
  end

  create_table "librarians", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email"
    t.string "password"
    t.integer "library_id"
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.boolean "approved", default: false, null: false
    t.index ["approved"], name: "index_librarians_on_approved"
    t.index ["email"], name: "index_librarians_on_email", unique: true
    t.index ["library_id"], name: "index_librarians_on_library_id"
    t.index ["reset_password_token"], name: "index_librarians_on_reset_password_token", unique: true
  end

  create_table "libraries", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "location"
    t.integer "max_days_borrowed"
    t.float "overdue_fines"
    t.integer "university_id"
    t.index ["university_id"], name: "index_libraries_on_university_id"
  end

  create_table "students", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email"
    t.string "password"
    t.string "education_level"
    t.integer "max_books_borrowed"
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "university_id"
    t.string "provider"
    t.string "uid"
    t.index ["email"], name: "index_students_on_email", unique: true
    t.index ["reset_password_token"], name: "index_students_on_reset_password_token", unique: true
    t.index ["university_id"], name: "index_students_on_university_id"
  end

  create_table "universities", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
