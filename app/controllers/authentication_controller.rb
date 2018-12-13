class AuthenticationController < ApplicationController
 skip_before_action :authenticate_request

 def authenticate
   command = AuthenticateUser.call(params[:email], params[:password])
   if command.success?
     render json: { status: "Ok", message: "Successfully logged in", auth_token: command.result }
   else
     render json: { status: "Nok", message: "Login failed", error: command.errors }, status: :unauthorized
   end
 end
end