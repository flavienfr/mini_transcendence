Rails.application.routes.draw do

	
  resources :players
	get '/users/:id', to: 'users#show'
	resources :users

	resources :user_achievements
	resources :achievements

	resources :ask_for_friendships
	resources :friendships
	
	resources :notifications

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