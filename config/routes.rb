# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'users#index'
  resources :users, only: %i[index show] do
    resources :posts do
      resources :comments, only: %i[new create]
      resources :likes, only: %i[new create]
    end
  end
  resources :comments, only: [:destroy]
  post '/send_email_notification', to: 'notifications#send_email_notification'
end
