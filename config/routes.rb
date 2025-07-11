Rails.application.routes.draw do
  devise_for :users

  namespace :admin do
    resources :users, only: [:index, :show, :edit, :update]
  end

  resources :documents
  resources :clients

  get "dashboard/index"
  root to: 'dashboard#index'

  get "up" => "rails/health#show", as: :rails_health_check
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
end
