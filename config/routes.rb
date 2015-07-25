Rails.application.routes.draw do

  root to: 'users#new'

  resources :spreadsheets
  resources :users, only: [:show, :create, :edit]

  get '/logout', to: 'sessions#destroy'
  get '/show', to: 'users#show'
  get '/help', to: 'users#help'

end
