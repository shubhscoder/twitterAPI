class AuthenticationController < ApplicationController
 skip_before_action :authenticate_request, only: %i[authenticate]

 def authenticate
   command = AuthenticateUser.call(params[:email], params[:password])
   user = User.find_by_email(params[:email])
   if command.success?
   	if BlacklistedToken.find_by_token(command.result).nil?
   		user.increment!(:login_count)
		user.update({failed_login_count: 0,current_login_ip: request.remote_ip.to_s})
    	render json: { status: "Ok", message: "Successfully logged in", auth_token: command.result }
    else
    	render json: { status: "Nok", message: "Invalid token.Please try again.", error: command.errors }, status: :unauthorized
    end
   else
    render json: { status: "Nok", message: "Login failed", error: command.errors }, status: :unauthorized
   end
 end

 def logout
 	if request.headers['Authorization'].present?
		to_be_blacklisted = BlacklistedToken.new(token: request.headers['Authorization'].split(' ').last)
		if to_be_blacklisted.save
			render json: { status: "Ok", message: "Successfully logged out"}
		else
			render json: { status: "Nok", message: "Already logged out" }
		end
	else
		render json: { status: "Nok", message: "Authorization token missing" }, status: :unauthorized
	end
 end
end