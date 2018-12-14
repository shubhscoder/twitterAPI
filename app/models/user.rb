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
end
