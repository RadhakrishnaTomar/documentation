Rails.application.routes.draw do
  devise_for :users

  root to: "dashboard#index"
  get "/dashboard", to: "dashboard#index", as: :dashboard

  namespace :admin do
    resources :users, only: [:index, :show, :new, :create, :edit, :update]
  end

  resources :documents do
    member do
      patch :update_category
    end
  end

  resources :clients do
    member do
      patch :assign_supervisor
      patch :assign_data_entry_operator
    end
  end

  get "up" => "rails/health#show", as: :rails_health_check
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
end
