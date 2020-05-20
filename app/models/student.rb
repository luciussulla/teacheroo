class Student < ApplicationRecord
	has_many :student_tests
	has_many :tests, through: :student_tests
	belongs_to :group
	has_secure_password


	alias_attribute :password_digest, :password

	def students_done_tests
		done_tests = self.student_tests
	end 
end
