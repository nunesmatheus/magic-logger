Rails.application.routes.draw do
  get 'sessions/create'

  root 'pages#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :logs, only: :create

  resources :sessions, only: [:new, :create]
end
