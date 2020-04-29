class Teacher < ApplicationRecord
	has_many :tests
	has_many :groups
	#the reverse is not created
end
