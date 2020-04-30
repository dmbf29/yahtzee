Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :games, only: [:create, :show] do
    resources :participations, only: [:create]
  end
end
