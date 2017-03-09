StellarLookout::Engine.routes.draw do

  namespace :api do
    namespace :v1 do
      resources :wards do
        resources :operations, only: [:create], defaults: {format: "json"}
      end
    end
  end

end
