Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'customers/create'
      post 'orders/add_item'
      put 'orders/show'
      get 'items/index'
      get 'items/show'
    end
  end
end
