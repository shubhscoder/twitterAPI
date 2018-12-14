class ChangeColumnName < ActiveRecord::Migration[5.2]
  def change
  	rename_column :users, :following, :following_count
  end
end
