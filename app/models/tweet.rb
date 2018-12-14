class Tweet < ApplicationRecord
	validates_presence_of :user_id,:tweet_content
	belongs_to :user, class_name: "User"
	has_many :likes, dependent: :destroy
end
