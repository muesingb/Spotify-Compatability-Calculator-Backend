Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :users, only: [:index, :show]

  get '/auth/spotify/callback', to: 'users#spotify'
  get '/user', to: "users#create"
  get '/match', to: "users#match"

  # namespace :api do
  #   namespace :v1 do
  #   end
  # end
end
