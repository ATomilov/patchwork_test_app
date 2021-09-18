Rails.application.routes.draw do
  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      resources :cryptocurrencies, only: %i[index] do
        collection do
          get :convert_currencies
        end
      end
    end
  end
end
