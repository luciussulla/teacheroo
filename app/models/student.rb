class Student < ApplicationRecord
	has_many :student_tests
	has_many :tests, through: :student_tests
	has_many :student_groups
	has_many :groups, throug: :student_groups
end
