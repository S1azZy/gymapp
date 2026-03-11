Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in the application layout)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  resources :password_resets, only: %i[new create edit update]
  resources :users, only: %i[new create]
  resource :session, only: %i[new create destroy]
  namespace :admin do
    get "/", to: "dashboard#show", as: :dashboard
    resources :body_parts, except: :show
    resources :muscle_groups, except: :show
    resources :equipment_types, except: :show
    resources :tags, except: :show
    resources :exercises, except: :show
  end
  get "dashboard", to: "dashboard#show"
  root "home#index"
end
