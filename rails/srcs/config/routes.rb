Rails.application.routes.draw do
  resources :users
	# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html


	root 'landing#index'
	resources :landing

	# TMP routes
	get '/profil', to: 'pages#profil', as: 'profil'
	get '/profil2', to: 'pages#profil2', as: 'profil2'

	get '/index', to: 'pages#index', as: 'index'


end
