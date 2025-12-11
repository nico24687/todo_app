Rails.application.routes.draw do
  # Task resources with additional toggle_complete action
  resources :tasks do
    member do
      patch :toggle_complete
    end
  end

  # Set the root route to the tasks index
  root "tasks#index"

  # Health check route for uptime monitoring
  get "up" => "rails/health#show", as: :rails_health_check

  # PWA routes
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
end
