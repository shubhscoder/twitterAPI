class UsersController < ApplicationController
	def new
		@user = User.new
	end

	def create
		@user = User.new(permitted_params)
		if @user.save
			render :json => {
				:status => "Successfully registered"
			}
		else
			render :json => {
				:status => "Error in registration"
				:error => "#{@user.errors}"
			}
	end

	private

	def permitted_params
		params.require(:user).permit(:username,:email,:password_digest)
	end
end
