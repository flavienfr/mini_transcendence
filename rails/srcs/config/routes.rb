Rails.application.routes.draw do

  	#get 'guilds/get_guild_owner' => 'guilds#get_guild_owner'

	
  resources :players
  resources :block_users
	get '/users/:id', to: 'users#show'
	resources :users

	resources :user_achievements
	resources :achievements

	resources :ask_for_friendships
	resources :friendships
	
	resources :notifications

	get 'ask_for_wars/is_in_request' => 'ask_for_wars#is_in_request'
	resources :ask_for_wars
	resources :wars

	get 'war_participations/war_info' => 'war_participations#war_info'
	resources :war_participations
	resources :war_times	
	
	resources :tournaments
	resources :tournament_participations

	resources :ask_for_games
	resources :games
	resources :game_participations
	resources :watches
	
	resources :channels
	resources :channel_participations
	resources :messages
	
	resources :guilds
	resources :guild_participations
	
	get '/sessions/oauth', to: 'sessions#oauth'
	post '/sessions/:id/validation', to: 'sessions#validation'
	resources :sessions
	
	# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

	root 'landing#index'
	resources :landing
	mount ActionCable.server => '/cable'

end