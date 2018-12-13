class User < ApplicationRecord
	has_secure_password
	validates_presence_of :username, :email, :firstname, :lastname
	validates :email, :uniqueness => true, format: { with: URI::MailTo::EMAIL_REGEXP }
	validates :username, :uniqueness => true, :length => {:in => 3..20}
	validates_date :date_of_birth, :before => lambda { 13.years.ago }, :before_message => "Must be at least 13 years old" # Checks that people are older than 13 years
end
