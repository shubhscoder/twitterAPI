Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
	post 'login', to: 'authentication#authenticate'
	post 'register', to: 'users#create'
	post 'logout', to: 'authentication#logout'
	get 'follow/:username', to: 'users#add_follower'
	get 'unfollow/:username', to: 'users#remove_follower'
end
