Rails.application.routes.draw do

  resources :spreadsheets
  root to: 'users#new'
  resources :users, only: [:show, :create, :edit]

  get '/merge', to: 'users#merge'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  get '/upload', to: 'users#show'

  get '/help', to: 'users#help'

  get '/fileuploads/*other', to: 'users#files'

end
