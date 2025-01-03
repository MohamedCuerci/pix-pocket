Rails.application.routes.draw do
  # get "pix_keys/index"
  # get "pix_keys/show"
  # get "pix_keys/new"
  # get "pix_keys/create"
  # get "pix_keys/edit"
  # get "pix_keys/update"
  # get "pix_keys/destroy"

  resources :pix_keys
#   devise_for :users, controllers: {
#     omniauth_callbacks: 'users/omniauth_callbacks'
#   }

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  # root "home#index"
  root "pix_keys#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  # root "posts#index"
end
