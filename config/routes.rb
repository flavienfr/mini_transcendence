Rails.application.routes.draw do
	# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

	root to: 'pages#live'

	get '/live', to: 'pages#live', as: 'live'
	get '/play', to: 'pages#play', as: 'play'
	get '/tournament', to: 'pages#tournament', as: 'tournament'
	get '/guild', to: 'pages#guild', as: 'guild'
	get '/war', to: 'pages#war', as: 'war'
	get '/profil', to: 'pages#profil', as: 'profil'
	get '/option', to: 'pages#option', as: 'option'

end
