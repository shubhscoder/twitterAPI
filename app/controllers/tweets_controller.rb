class TweetsController < ApplicationController
	def new
  		@tweet = Tweet.new
	end	

  	def create
  		@tweet = Tweet.new(permitted_params)
  		if @tweet.save
  			current_user.increment!(:number_of_tweets)
  			@tweet.update(:user_id => current_user.id)
  			render :json => { status: "Ok", message: "Tweeted Successfully" }
  		else
  			render :json => { status: "Nok", message: "Problem creating a tweet. Please try again" }
  		end
  	end

  	def delete_tweet
  		tweet_to_be_deleted = Tweet.find_by_id(params[:tweet_id])
  		if tweet_to_be_deleted.nil?
  			stat = "Nok"
  			msg = "Tweet does not exist"
  		elsif tweet_to_be_deleted.user_id != current_user.id
  			stat = "Nok"
  			msg = "You cannot delete tweets made by others"
  		else
  			stat = "Ok"
  			msg = "Deleted tweet successfully"
  			tweet_to_be_deleted.destroy
  		end
  		render :json => { status: stat, message: msg }
  	end

  	private 

  	def permitted_params
  		params["user_id"] = current_user.id
  		params.permit(:tweet_content, :user_id)
  	end
end
