class User < ApplicationRecord
	has_secure_password
	validates_presence_of :username, :email, :firstname, :lastname
	validates :email, :uniqueness => true, format: { with: URI::MailTo::EMAIL_REGEXP }
	validates :username, :uniqueness => true, :length => {:in => 3..20}
	validates_date :date_of_birth, :before => lambda { 13.years.ago }, :before_message => "Must be at least 13 years old" # Checks that people are older than 13 years

	has_many :follows
	has_many :follower_relationships, foreign_key: :following_id, class_name: 'Follow'
	has_many :followers, through: :follower_relationships, source: :follower
	has_many :following_relationships, foreign_key: :user_id, class_name: 'Follow'
	has_many :following, through: :following_relationships, source: :following
	has_many :tweets, dependent: :destroy
	has_many :likes, dependent: :destroy

	def add_follow(user_to_be_followed)
		if self.is_current_user_following(user_to_be_followed).nil?
 			following_relation = Follow.new(:user_id => self.id, :following_id => user_to_be_followed.id)
			following_relation.save
			self.increment!(:following_count)
			user_to_be_followed.increment!(:followers_count)
			return true
		else
			return false
		end
	end

	def unfollow_user(user_to_be_unfollowed)
		relationship = self.is_current_user_following(user_to_be_unfollowed)
		if relationship.nil?
			return false
		else
			relationship.destroy
			self.decrement!(:following_count)
			user_to_be_unfollowed.decrement!(:followers_count)
		end
	end

	def is_current_user_following(this_user)
		is_relationship_present = Follow.where("user_id = ? and following_id = ?", self.id, this_user.id)
		if is_relationship_present.empty?
			return nil
		else 
			return is_relationship_present[0]
		end
	end

	def get_followers_tweets
		user_follower_tweets = Tweet.select("t.id, t.created_at, t.tweet_content, t.user_id").from("tweets t").joins("INNER JOIN follows as f ON t.user_id = f.following_id").where("f.user_id = ?",self.id)
		array_of_tweets = filter_tweets(user_follower_tweets)
		return array_of_tweets,array_of_tweets.size
	end

	def get_tweets
		req_tweets = Tweet.where(user_id: self.id)
		array_of_tweets = filter_tweets(req_tweets)
		return array_of_tweets,array_of_tweets.size
	end

	def get_my_followers
		filter_required_info(Follow.where("following_id = ?",self.id))
	end

	def get_my_following
		filter_required_info(self.follows)
	end

	private

	def filter_required_info(following_relationships)
		filtered_follow_relationship = []
		for i in following_relationships
			follower_instance = {}
			follower_instance["username"] = User.find(i.following_id).username
			follower_instance["since"] = i.created_at
			filtered_follow_relationship << follower_instance
		end
		return filtered_follow_relationship
	end

	def filter_tweets(tweets_arr)
		array_of_tweets = []
		for i in tweets_arr
			dict_tweet = {}
			dict_tweet["username"] = User.find(i.user_id).username
			dict_tweet["tweet_content"] = i.tweet_content
			dict_tweet["created_at"] = i.created_at
			dict_tweet["tweet_id"] = i.id
			array_of_tweets << dict_tweet 
		end
		array_of_tweets = array_of_tweets.sort_by {|k| k["created_at"] }
		return array_of_tweets
	end
end
