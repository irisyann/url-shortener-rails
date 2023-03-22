Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  ######## Authentication Routes ########
  get "sign_up", to: "registrations#new"
  post "sign_up", to: "registrations#create"

  get "password", to: "passwords#edit", as: :edit_password
  patch "password", to: "passwords#update"

  get "password/reset", to: "password_resets#new"
  post "password/reset", to: "password_resets#create"
  get "password/reset/edit", to: "password_resets#edit"
  patch "password/reset/edit", to: "password_resets#update"

  get "sign_in", to: "sessions#new"
  post "sign_in", to: "sessions#create"

  delete "logout", to: "sessions#destroy"


  ######## Application Routes ########
  root "main#index"

  resources :url_creations, only: [:new, :create] do
    resources :short_urls, only: [:new, :create] do
      resources :geolocations, only: [:new, :create]
    end
  end

  get "usage_report", to: "usage_reports#index"

  get "/:short_path", to: "url_creations#redirect"
  

end
