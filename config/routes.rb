Rails.application.routes.draw do
  get 'charges/new'
  get 'charges/create'
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  post '/events/:id/attendances/new', to: 'attendances#create'
  root 'events#index'
  resources :events
  resources :users

  resources :events, only: [:show] do
    resources :attendances, only: [:new, :create, :index]
  end

  resources :events, only: [:show] do
    resources :images, only: [:create]
  end

  resources :admin, only: [:index]

end
