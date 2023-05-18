Rails.application.routes.draw do
  namespace :api do
    namespace :v0 do
      get "/markets/:id/nearest_atm", to: "markets#nearby_atms"
      get "/markets/search", to: "markets#search"
      delete "/market_vendors", to: "market_vendors#destroy"
      resources :market_vendors, only: [:create]
      resources :vendors, only: [:show, :create, :update, :destroy]
      resources :markets, only: [:index, :show] do
        resources :vendors, only: [:index]
      end
    end
  end
end
