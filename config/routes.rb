Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
	post 'login', to: 'authentication#authenticate'
	post 'register', to: 'users#create'
	post 'logout', to: 'authentication#logout'
	get 'follow/:username', to: 'users#add_follower'
	get 'unfollow/:username', to: 'users#remove_follower'
	post 'tweet', to: 'tweets#create'
	get 'timeline', to: 'users#get_followers_tweets'
	get 'followers', to: 'users#get_users_followers'
	get 'following', to: 'users#get_users_following'
	delete 'remove/:tweet_id', to: 'tweets#delete_tweet'
	get 'like/:tweet_id', to: 'likes#like_tweet'
	get 'unlike/:tweet_id', to: 'likes#unlike_tweet'
end
