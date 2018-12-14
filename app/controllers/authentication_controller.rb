class AuthenticationController < ApplicationController
 skip_before_action :authenticate_request, only: %i[authenticate]

 def authenticate
   command = AuthenticateUser.call(params[:email], params[:password])
   user = User.find_by_email(params[:email])
   if command.success?
   		user.increment!(:login_count)
		user.update({current_login_at: Time.new.strftime("%Y-%m-%d %H:%M:%S"), failed_login_count: 0, current_login_ip: request.remote_ip.to_s})
    	render json: { status: "Ok", message: "Successfully logged in", auth_token: command.result }
   else
		user.increment!(:failed_login_count)
		render json: { status: "Nok", message: "Login failed", error: command.errors }, status: :unauthorized
   end
 end

 def logout
	user_token = request.headers['Authorization'].split(' ').last
	to_be_blacklisted = BlacklistedToken.new(token: user_token)
	to_be_blacklisted.save
	user = User.find_by_id(current_user.id)
	user.update({last_login_ip: request.remote_ip.to_s, current_login_at: nil, current_login_ip: nil})
	render json: { status: "Ok", message: "Successfully logged out"}
 end
end