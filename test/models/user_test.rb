require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'validity_of_user_with_zero_params' do
  	user = User.new
  	assert_not user.valid?
  end

  test 'validity_of_user_with_subset_of_params' do
  	user = User.new(:firstname =>"Shubham", :username => "shubhscoder", :email => "shubhs@gmail.com")
  	assert_not user.valid?
  end

  test 'validity_of_user_with_invalid_email' do
  	user = User.new(:username => "scube", :email => "aaa@.com", :password => "abcd1234", :firstname => "Shubham", :lastname => "Sangu", :date_of_birth => "1997-08-06", :date_of_joining => "1997-08-06")
  	assert_not user.valid?

  	user = User.new(:username => "scube2", :email => "aaa.com", :password => "abcd1234", :firstname => "Shubham", :lastname => "Sangu", :date_of_birth => "1997-08-06", :date_of_joining => "1997-08-06")
  	assert_not user.valid?

  	user = User.new(:username => "scube3", :email => "aaacom", :password => "abcd1234", :firstname => "Shubham", :lastname => "Sangu", :date_of_birth => "1997-08-06", :date_of_joining => "1997-08-06")
  	assert_not user.valid?

  	user = User.new(:username => "scube4", :email => "aaa@..gmail.com", :password => "abcd1234", :firstname => "Shubham", :lastname => "Sangu", :date_of_birth => "1997-08-06", :date_of_joining => "1997-08-06")
  	assert_not user.valid?
  end

  test 'uniqueness_of_user' do
  	user = User.new(:username => "scube", :email => "aaa@gmail.com", :password => "abcd1234", :firstname => "Shubham", :lastname => "Sangu", :date_of_birth => "1997-08-06", :date_of_joining => "1997-08-06")
  	assert user.valid?
  	user.save
  	user1 = User.new(:username => "scube", :email => "aaakjhjk@gmail.com", :password => "abcd1234", :firstname => "Shubham", :lastname => "Sangu", :date_of_birth => "1997-08-06", :date_of_joining => "1997-08-06")
 		assert_not user1.valid?
 		user.destroy
  end

  test 'uniqueness_of_email' do
  	user = User.new(:username => "scube", :email => "aaa@gmail.com", :password => "abcd1234", :firstname => "Shubham", :lastname => "Sangu", :date_of_birth => "1997-08-06", :date_of_joining => "1997-08-06")
  	assert user.valid?
  	user.save

  	user1 = User.new(:username => "scube97", :email => "aaa@gmail.com", :password => "abcd1234", :firstname => "Shubham", :lastname => "Sangu", :date_of_birth => "1997-08-06", :date_of_joining => "1997-08-06")
  	assert_not user1.valid?
  	user.destroy
	end
	
	test 'correct_date_format' do
		user = User.new(:username => "scube", :email => "aaa@gmail.com", :password => "abcd1234", :firstname => "Shubham", :lastname => "Sangu", :date_of_birth => "1997-08-06", :date_of_joining => "1997-08-06")
		assert user.valid?
	end

	test 'incorrect_date_format' do
		user = User.new(:username => "scube", :email => "aaa@gmail.com", :password => "abcd1234", :firstname => "Shubham", :lastname => "Sangu", :date_of_birth => "asfioadusof", :date_of_joining => "1997-08-06")
		assert_not user.valid?

		user = User.new(:username => "scube", :email => "aaa@gmail.com", :password => "abcd1234", :firstname => "Shubham", :lastname => "Sangu", :date_of_birth => "21/06/97", :date_of_joining => "1997-08-06")
		assert_not user.valid?
	end

  test 'perfect_object_gets_created' do
  	user = User.new(:username => "scube", :email => "aaa@gmail.com", :password => "abcd1234", :firstname => "Shubham", :lastname => "Sangu", :date_of_birth => "1997-08-06", :date_of_joining => "1997-08-06")
  	assert user.valid?
  end
end
