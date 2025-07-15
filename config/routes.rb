Rails.application.routes.draw do
  devise_for :users

  root to: "dashboard#index"

  namespace :admin do
    resources :users, only: [:index, :show, :new, :create, :edit, :update]
  end

  resources :documents, only: [:new, :create, :index, :show]
  resources :clients

  get "up" => "rails/health#show", as: :rails_health_check
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
end
