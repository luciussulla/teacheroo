# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_05_06_142733) do

  create_table "answers", force: :cascade do |t|
    t.string "content"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "group_tests", force: :cascade do |t|
    t.integer "test_id", null: false
    t.integer "group_id", null: false
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["group_id"], name: "index_group_tests_on_group_id"
    t.index ["test_id"], name: "index_group_tests_on_test_id"
  end

  create_table "groups", force: :cascade do |t|
    t.string "name"
    t.integer "teacher_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "question_answers", force: :cascade do |t|
    t.integer "question_id", null: false
    t.integer "answer_id", null: false
    t.integer "student_test_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["answer_id"], name: "index_question_answers_on_answer_id"
    t.index ["question_id"], name: "index_question_answers_on_question_id"
    t.index ["student_test_id"], name: "index_question_answers_on_student_test_id"
  end

  create_table "question_sets", force: :cascade do |t|
    t.integer "test_id", null: false
    t.integer "question_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["question_id"], name: "index_question_sets_on_question_id"
    t.index ["test_id"], name: "index_question_sets_on_test_id"
  end

  create_table "questions", force: :cascade do |t|
    t.string "content"
    t.string "option1"
    t.string "option2"
    t.string "option3"
    t.string "option4"
    t.string "correct_answer"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "student_groups", force: :cascade do |t|
    t.integer "student_id", null: false
    t.integer "group_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["group_id"], name: "index_student_groups_on_group_id"
    t.index ["student_id"], name: "index_student_groups_on_student_id"
  end

  create_table "student_tests", force: :cascade do |t|
    t.integer "test_id", null: false
    t.integer "student_id", null: false
    t.integer "grade"
    t.integer "time_taken"
    t.datetime "taken_at"
    t.string "remarks"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["student_id"], name: "index_student_tests_on_student_id"
    t.index ["test_id", "student_id"], name: "my_custom_index", unique: true
    t.index ["test_id"], name: "index_student_tests_on_test_id"
  end

  create_table "students", force: :cascade do |t|
    t.string "password"
    t.string "login"
    t.string "name"
    t.integer "year"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "group_id"
  end

  create_table "teachers", force: :cascade do |t|
    t.string "name"
    t.integer "control_level"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "tests", force: :cascade do |t|
    t.string "test_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "teacher_id"
  end

  add_foreign_key "group_tests", "groups"
  add_foreign_key "group_tests", "tests"
  add_foreign_key "question_answers", "answers"
  add_foreign_key "question_answers", "questions"
  add_foreign_key "question_answers", "student_tests"
  add_foreign_key "question_sets", "questions"
  add_foreign_key "question_sets", "tests"
  add_foreign_key "student_groups", "groups"
  add_foreign_key "student_groups", "students"
  add_foreign_key "student_tests", "students"
  add_foreign_key "student_tests", "tests"
end
