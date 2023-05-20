Rails.application.routes.draw do
  namespace :api do
    namespace :v0 do
      get "vendors", to: "vendors#popularity_by_state"
      get "vendors/popular_states", to: "vendors#popular_states"
      get "/markets/:id/nearest_atm", to: "markets#nearby_atms"
      get "/markets/search", to: "markets#search"
      delete "/market_vendors", to: "market_vendors#destroy"
      get "/vendors/multiple_states", to: "vendors#multiple_states"
      resources :market_vendors, only: [:create]
      resources :vendors, only: [:show, :create, :update, :destroy]
      resources :markets, only: [:index, :show] do
        resources :vendors, only: [:index]
      end
    end
  end
end
