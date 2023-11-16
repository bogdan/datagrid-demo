Rails.application.routes.draw do
  scope format: false do
    # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
    # Can be used by load balancers and uptime monitors to verify that the app is live.
    get "up" => "rails/health#show", as: :rails_health_check

    root controller: :home, action: :index

    resources :users, only: [:index]
    resources :time_entries, only: [:index]
    resources :documents, only: [:index]

    # resources :grids, :only => [:index, :create, :show]
  end
end
