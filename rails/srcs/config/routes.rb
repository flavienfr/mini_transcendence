Rails.application.routes.draw do

	resources :notifications
	resources :ask_for_friendships
	resources :tournament_participations
	resources :ask_for_wars
	resources :war_times

	get '/wars/info', to: 'wars#info'
	resources :war_participations
	resources :wars


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

	get '/sessions/oauth', to: 'sessions#oauth'
	post '/sessions/:id/validation', to: 'sessions#validation'
	resources :sessions

	get '/users/:id', to: 'users#show'
	resources :users
	
	# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

	root 'landing#index'
	resources :landing
	mount ActionCable.server => '/cable'

end