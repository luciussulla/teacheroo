class Test < ApplicationRecord
	has_many :question_sets
	has_many :questions, through: :question_sets
	accepts_nested_attributes_for :questions, :reject_if => lambda { |a| a[:content].blank? }, :allow_destroy => true
	has_many :student_tests
	has_many :students, through: :student_tests
	belongs_to :teacher
end
