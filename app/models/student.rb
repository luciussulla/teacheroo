class Student < ApplicationRecord
	has_many :student_tests
	has_many :tests, through: :student_tests
end
