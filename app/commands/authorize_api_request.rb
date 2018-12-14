class AuthorizeApiRequest
	prepend SimpleCommand

	def initialize(headers = {})
		@headers = headers
	end

	def call
		user
	end

	private

	attr_reader :headers

	def user
		@user ||= User.find(decoded_auth_token[:user_id]) if decoded_auth_token
		@user || errors.add(:token, 'Invalid token') && nil
	end

	def decoded_auth_token
		@decoded_auth_token ||= JsonWebToken.decode(http_auth_header)
	end

	def http_auth_header
		if headers['Authorization'].present?
			recvd_token = headers['Authorization'].split(' ').last
			if BlacklistedToken.find_by_token(recvd_token).nil?
				return recvd_token
			else
				errors.add(:token, 'Blacklisted token')
			end
		else
			errors.add(:token, 'Missing token')
		end
		nil
	end
end