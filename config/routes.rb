Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # All user routes
  devise_for :users

  root to: 'pages#home'

  get '/dashboard', to: 'pages#dashboard'

  resources :rents, only: [:update, :show]
  resources :flats
  resources :incidents, only: [:new, :create]
  resources :workers, only: [:index]
end
