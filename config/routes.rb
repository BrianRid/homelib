Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # All user routes
  devise_for :users

  root to: 'pages#home'

  get '/dashboard', to: 'pages#dashboard2'

  resources :rents, only: [:update, :show]
  resources :flats
  resources :incidents, only: [:new, :create, :show, :update,  :delete]
  resources :workers, only: [:index] do
    resources :user_workers, only: :create
  end
  resources :user_workers, only: :destroy
  resources :documents, only: [:new, :create, :destroy]
end
