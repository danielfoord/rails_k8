require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'
  
  root "articles#index"

  # get "/articles", to: "articles#index"
  # get "/articles/:id", to: "articles#show"

  resources :articles

  get '/status', to: 'status#index'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  
end
