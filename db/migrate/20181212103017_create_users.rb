class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :username
      t.string :password
      t.integer :number_of_tweets
      t.string :email
      t.string :firstname
      t.string :lastname
      t.date :date_of_birth
      t.integer :login_count
      t.integer :failed_login_count
      t.datetime :current_login_at
      t.string :current_login_ip
      t.string :last_login_ip
      t.date :date_of_joining
      t.integer :followers
      t.integer :following
      t.string :time_zone
      t.timestamps
    end
  end
end
