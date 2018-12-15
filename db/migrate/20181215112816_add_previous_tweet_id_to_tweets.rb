class AddPreviousTweetIdToTweets < ActiveRecord::Migration[5.2]
  def change
    add_column :tweets, :previous_tweet_id, :integer, :default => 0
  end
end
