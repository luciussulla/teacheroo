class Test < ApplicationRecord
	has_many :question_sets
	has_many :questions, through: :question_sets
	accepts_nested_attributes_for :questions, :reject_if => lambda { |a| a[:content].blank? }, :allow_destroy => true
end
