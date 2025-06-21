Rails.application.routes.draw do
  root "static_pages#home"

  get "static_pages/terms"
  get "static_pages/privacy"
  get "static_pages/contact"

  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions: "users/sessions",
    passwords: "users/passwords"
  }
  get "users/profile" => "users#show"
  resources :articles do
    resources :comments, only: [ :create, :edit, :update, :destroy ]
  end
  resources :study_records
  resources :learning_items do
    member do
      patch :toggle_complete
    end
  end
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
