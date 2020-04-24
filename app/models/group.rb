class Group < ApplicationRecord
	has_many :student_groups
	has_many :students, through: :student
end
