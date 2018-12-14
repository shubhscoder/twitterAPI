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
			errors = {}
			@user.errors.each do |attribute, message|
				errors[attribute] = []
				attribute_errors = @user.errors[attribute]
				if attribute_errors.kind_of?(Array)
					attribute_errors.each do |error|
						errors[attribute] << error
					end
				else
					errors[attribute] << attribute_errors
				end
			end
			render :json => { status: "Nok", message: "Registration was not successful", error: errors }
		end
	end

	def add_follower
		user_to_be_followed = User.find_by_username(params[:username])
		stat = "Nok"
		if user_to_be_followed.nil?
			msg = "No such User"
		elsif current_user.add_follow(user_to_be_followed)
			stat = "Ok"
			msg = "Started following #{params[:username]}"
		else
			msg = "You already follow this user"
		end
		render :json => { status: stat, message: msg }
	end

	def remove_follower
		user_to_be_unfollowed = User.find_by_username(params[:username])
		stat = "Nok"
		if user_to_be_unfollowed.nil?
			msg = "No such User"
		elsif current_user.unfollow_user(user_to_be_unfollowed)
			stat = "Ok"
			msg = "Unfollowed #{params[:username]} Successfully"
		else 
			msg = "You can't unfollow a user that you don't follow"
		end
		render :json => { status: stat, message: msg }
	end

	def get_followers_tweets
		user_feed, size = current_user.get_followers_tweets
		msg = "No tweets in the feed"
		if size>0
			msg = user_feed
		end
		render :json => { status: "Ok", message: msg }
	end

	def get_users_followers
		followers_list = current_user.get_my_followers
		msg = "You have no followers"
		if followers_list.size > 0
			msg = followers_list
		end
		render :json => { status: "Ok", message: msg }
	end

	def get_users_following
		following_list = current_user.get_my_following
		msg = "You have no following"
		if following_list.size > 0
			msg = following_list
		end
		render :json => { status: "Ok", message: msg }
	end
	
	private

	def permitted_params
		params["date_of_joining"] = Time.new.strftime("%Y-%m-%d")
		params.permit(:username, :email, :password, :firstname, :lastname, :date_of_birth, :date_of_joining)
	end
end
