Rails.application.routes.draw do
  get 'charges/new'
  get 'charges/create'
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get '/events/:id/attendances/new', to: 'attendances#new'
  get '/events/:id/attendances', to: 'attendances#index'
  root 'events#index'
  resources :events
  resources :users
  resources :charges, only: [:new, :create]

end
