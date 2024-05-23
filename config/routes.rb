Rails.application.routes.draw do
  devise_for :admins,
    path: "",
    controllers: {
      omniauth_callbacks: "admin/auth/omniauth_callbacks"
    },
    skip: [:sessions, :registrations, :passwords]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get "login" => "admin/auth/sessions#new", as: :new_admin_session
  post "debug_login" => "admin/auth/sessions#debug_login", as: :debug_admin_session
  delete "logout" => "admin/auth/sessions#destroy", as: :delete_admin_session

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  get "calendar_events" => "admin/calendar_events#index", as: :calendar_events
  patch "calendar_events/:id" => "admin/calendar_events#update", as: :calendar_event

  # Defines the root path route ("/")
  # root "posts#index"
  root to: "admin/home#index"
end
