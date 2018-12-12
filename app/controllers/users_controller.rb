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
end
