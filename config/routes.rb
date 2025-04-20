Rails.application.routes.draw do
  resource :session
  resource :registration, only: %i[ new create]
  resources :passwords, param: :token
  resources :profiles, only: %i[ show edit update ]

  resources :daily_logs do
    resources :food_entries, only: %i[ create destroy ]
  end

  resources :food_searches, only: %i[new index]

  get "up" => "rails/health#show", as: :rails_health_check

  root "dashboard#show"
end
