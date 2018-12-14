class LikesController < ApplicationController
	before_action :find_tweet

	def like_tweet
		stat = "Nok"
		if @tweet.nil?
			msg = "No such tweet"
		elsif Like.where(:user_id => current_user.id, :tweet_id => @tweet.id).size > 0
			msg = "You have already liked this tweet"
		else
			new_like = Like.new(:user_id => current_user.id, :tweet_id => @tweet.id)
			@tweet.increment!(:number_of_likes)
			new_like.save
			stat = "Ok"
			msg = "Liked tweet successfully"
		end
		render :json => { status: stat, message: msg }
	end

	def unlike_tweet
		stat = "Nok"
		if @tweet.nil?
			msg = "No such tweet"
		else
			like_record = Like.where(:user_id => current_user.id, :tweet_id => @tweet.id)
			if like_record.size == 0
				msg = "You can only unlike tweets that you liked"
			else
				@tweet.decrement!(:number_of_likes)
				like_record.first.destroy
				msg = "Unliked tweet"
				stat = "Ok"
			end
		end
		render :json => { status: stat, message: msg }
	end

	private 

	def find_tweet
		@tweet = Tweet.find_by_id(params[:tweet_id])
	end
end
