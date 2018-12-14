class ChangeFollowersToFollowersCountInUsers < ActiveRecord::Migration[5.2]
  def change
  	rename_column :users, :followers, :followers_count
  end
end
