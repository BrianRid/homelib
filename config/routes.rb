Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # All user routes
  devise_for :users
  # Redirect user after loggin directly in the dashboard
  get '/user' => "pages#dashboard", :as => :user_root

  root to: 'pages#home'

  get '/dashboard', to: 'pages#dashboard'

  resources :rents, only: [:update]
end
