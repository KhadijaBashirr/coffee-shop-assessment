Rails.application.routes.draw do
  devise_for :users, defaults: { format: :json }

  namespace :api do
    namespace :v1 do
      resources :items, only: %i[index show]
      resources :orders, only: %i[create show update]
      resources :categories, only: [:index]
    end
  end
end
