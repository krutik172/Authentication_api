Rails.application.routes.draw do
  resources :items
  # resources :sessions, only: [:create]
  resources :registrations
  delete :logout, to: "sessions#logout"
  get :logged_in, to: "sessions#logged_in"
  post 'authenticate', to: 'sessions#authenticate'
  resources :account_activations, only: [:edit]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
