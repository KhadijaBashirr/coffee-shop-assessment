require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/jobmonitor'

  namespace :api do
    namespace :v1 do
      resources :customers, only: [] do
        collection do
          get :populate_with_email
        end
      end
      resources :orders do
        collection do
          post :add_item
          post :place_order
        end
      end
      resources :items, only: %i[index show]
    end
  end
end
