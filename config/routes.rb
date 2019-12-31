Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # root to: 'users#index'
  resources :users, only: [:index, :show]

  get '/auth/spotify/callback', to: 'users#spotify'
  get '/user', to: "users#create"

  # OAuth
  namespace :api do
    namespace :v1 do
      get '/login', to: "auth#spotify_request"
      get '/auth', to: "auth#show"
    end
  end
end
