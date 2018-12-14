class AddNumberOfLikesToTweets < ActiveRecord::Migration[5.2]
  def change
    add_column :tweets, :number_of_likes, :integer, :default => 0
  end
end
