# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api, path: '' do
    namespace :v1 do
      resources :users
      resources :divings
      resources :trainings
      resources :rentals
      resources :specialties
      get '/google_drive_images' => 'google_drive_images#index'
    end
  end
end
