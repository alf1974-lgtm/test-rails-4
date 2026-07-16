Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  namespace :api do
    namespace :v1 do
      # Student-facing routes
      resources :students, only: [:show] do
        member do
          get :courses
        end
      end

      # General read-only resources (handy for browsing data)
      resources :departments,    only: [:index, :show]
      resources :courses,        only: [:index, :show]
      resources :semesters,      only: [:index, :show]
      resources :class_sessions, only: [:index, :show]
    end
  end
end
