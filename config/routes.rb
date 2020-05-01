Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :games, only: [:index,:create, :show] do
    resources :participations, only: [:create]
    resources :submissions, only: [:create, :update]
  end
  resources :participations, only: [:destroy]
  get '/search', to: 'games#search', as: :search
end
