class User < ApplicationRecord
	validates_presence_of :username, :email, :password, :firstname, :date_of_birth, :date_of_joining
	validates :email, :uniqueness => true, format: { with: URI::MailTo::EMAIL_REGEXP }
	validates :username, :uniqueness => true, :length => {:in => 3..20}
	validates_length_of :password, :in => 6..70
end
