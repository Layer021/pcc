Rails.application.routes.draw do
  namespace :api do
    resources :calendar_events, only: [:index, :show]
  end
end
