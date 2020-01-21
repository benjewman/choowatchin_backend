Rails.application.routes.draw do

  default_url_options :host => "localhost:3000"
  resources :shows
  resources :reviews
  resources :users
  resources :follows
  post '/auth', to: 'auth#create'
  # post '/auth', to: 'user#log_in'
  get '/current_user', to: 'auth#show'
  # get '/current_user', to: 'user#auth'
  root 'welcome#index'
  get '/friends/:id', to: 'friends#index'
  get '/topfive', to: 'users#topfive'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
