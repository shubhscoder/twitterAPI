require 'test_helper'

class LikeTest < ActiveSupport::TestCase
  test 'like_without_user_id' do
  	like_obj = likes(:one)
  	assert_not like_obj.save	
  end

  test 'like_without_tweet_id' do
  	like_obj = likes(:two)
  	assert_not like_obj.save
  end
end
