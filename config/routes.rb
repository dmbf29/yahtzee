Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :games, only: [:index,:create, :show] do
    resources :participations, only: [:create]
    resources :submissions, only: [:create, :update]
    member do
      patch :finish
    end
    post '/cursor_place', to: 'submissions#cursor_place', as: :cursor_place
  end
  resources :participations, only: [:destroy, :update] do
    collection do
      patch :order
    end
  end
  resources :users, only: [:index, :update] do
    member do
      patch :big_boys
      post :impersonate
    end
    collection do
      post :stop_impersonating
    end
  end
  get '/search', to: 'games#search', as: :search
end
