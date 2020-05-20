class Teacher < ApplicationRecord
	has_many :tests
	has_many :groups
	#the reverse is not created
	has_secure_password
	alias_attribute :password_digest, :password
end

