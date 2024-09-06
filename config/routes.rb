Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'customers/populate_with_email'
      resources :orders, only: [:show] do
        collection do
          post :add_item
          post :place_order
        end
      end
      get 'items/index'
      get 'items/show'
    end
  end
end
