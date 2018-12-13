class AddDefaultValueToLoginCount < ActiveRecord::Migration[5.2]
  def change
  	change_column_default :users, :number_of_tweets, 0
  	change_column_default :users, :login_count, 0
  	change_column_default :users, :failed_login_count, 0
 	change_column_default :users, :followers, 0
 	change_column_default :users, :following, 0
  end
end
