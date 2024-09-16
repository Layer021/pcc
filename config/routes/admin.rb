Rails.application.routes.draw do
  devise_for :admins,
    controllers: {
      omniauth_callbacks: "admin/auth/omniauth_callbacks"
    },
    skip: [:sessions, :registrations, :passwords]

  namespace :admin do
    # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
    get "login" => "auth/sessions#new", as: :new_admin_session
    delete "logout" => "auth/sessions#destroy", as: :delete_admin_session
    
    if Rails.env.development?
      post "debug_login" => "auth/sessions#debug_login", as: :debug_admin_session
    end
    
    get "calendar_events" => "calendar_events#index", as: :calendar_events
    patch "calendar_events/:id" => "calendar_events#update", as: :calendar_event

    # Defines the root path route ("/")
    # root "posts#index"
    root to: "home#index"
  end
end
