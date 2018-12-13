class UsersController < ApplicationController
	skip_before_action :authenticate_request, only: %i[create]
	def new
		@user = User.new
	end

	def create
		@user = User.new(permitted_params)
		if @user.save
			msg = { status: "Ok", message: "Successfully registered!" }
			render :json => msg
		else
			msg = { status: "Nok", message: "#{@user.errors}" }
			render :json => msg
		end
	end

	private

	def permitted_params
		params.permit(:username,:email,:password)
	end
end
