class User < ApplicationRecord
	has_secure_password
	validates_presence_of :username, :email
	validates :email, :uniqueness => true, format: { with: URI::MailTo::EMAIL_REGEXP }
	validates :username, :uniqueness => true, :length => {:in => 3..20}
end
