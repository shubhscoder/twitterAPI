class BlacklistedToken < ApplicationRecord
	validates :token, :uniqueness => true
end
