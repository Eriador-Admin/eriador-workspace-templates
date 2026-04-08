Rails.application.routes.draw do
  get "health", to: "health#show"

  namespace :api do
    namespace :v1 do
      resources :items, only: [:index, :create]
    end
  end
end
