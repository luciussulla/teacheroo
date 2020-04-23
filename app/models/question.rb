class Question < ApplicationRecord
	has_many :question_sets
	has_many :tests, through: :question_sets
end
