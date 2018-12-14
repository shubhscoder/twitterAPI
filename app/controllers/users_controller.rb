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

	def add_follower
		user_to_be_followed = User.find_by_username(params[:username])
		if user_to_be_followed.nil?
			render :json => { status: "Nok", message: "No such User"}
		elsif current_user.add_follow(user_to_be_followed)
			render :json => { status: "Ok", message: "Started following #{params[:username]}"}
		else
			render :json => { status: "Nok", message: "You already follow this user"}
		end
	end

	def remove_follower
		user_to_be_unfollowed = User.find_by_username(params[:username])
		if user_to_be_unfollowed.nil?
			render :json => { status: "Nok", message: "No such User"}
		elsif current_user.unfollow_user(user_to_be_unfollowed)
			render :json => { status: "Ok", message: "Unfollowed #{params[:username]} Successfully"}
		else 
			render :json => { status: "Nok", message: "You can't unfollow a user that you don't follow"}
		end
	end

	private

	def permitted_params
		params.permit(:username,:email,:password)
	end
end
