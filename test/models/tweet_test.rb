require 'test_helper'

class TweetTest < ActiveSupport::TestCase
  test 'tweet_without_user_id' do
  	tweet_without_id = tweets(:tweet_without_user_id)
  	assert_not tweet_without_id.save
  end

  test 'tweet_without_content' do
  	tweet_without_text = tweets(:tweet_without_content)
  	assert_not tweet_without_text.save
  end
end
