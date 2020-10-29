Rails.application.routes.draw do

  resources :ask_for_wars
  resources :war_times
  resources :war_participations
  resources :wars
	#get 'guilds/get_guild_owner' => 'guilds#get_guild_owner'
	
	get '/users/:id', to: 'users#show'
  
  	resources :tournaments
  	resources :ask_for_games
  	resources :game_participations
  	resources :games
  	resources :messages
  	resources :channel_participations
  	resources :channels
  	resources :user_achievements
  	resources :achievements
  	resources :friendships
  	resources :guild_participations
  	resources :guilds
	resources :sessions
	
	resources :users
	# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

	root 'landing#index'
	resources :landing

end