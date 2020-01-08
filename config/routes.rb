Rails.application.routes.draw do
  resources :shows
  resources :reviews
  resources :users
  post '/auth', to: 'auth#create'
  get '/current_user', to: 'auth#show'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
