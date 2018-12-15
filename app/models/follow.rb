class Follow < ApplicationRecord
	validates_uniqueness_of :user_id, scope: %i[following_id]
	belongs_to :follower, foreign_key: 'user_id', class_name: 'User'
	belongs_to :following, foreign_key: 'following_id', class_name: 'User'
end
