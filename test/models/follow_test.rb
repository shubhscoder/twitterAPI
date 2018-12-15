require 'test_helper'

class FollowTest < ActiveSupport::TestCase
  test 'follow_relation_without_user_id' do
  	follow_relation = follows(:follow_without_user_id)
  	assert_not follow_relation.save
  end

  test 'follow_relation_without_following_id' do
  	follow_relation = follows(:follow_without_following_id)
  	assert_not follow_relation.save
  end
end
