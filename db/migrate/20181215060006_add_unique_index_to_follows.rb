class AddUniqueIndexToFollows < ActiveRecord::Migration[5.2]
  def change
  	add_index :follows, [:user_id, :following_id], unique: true
  end
end
