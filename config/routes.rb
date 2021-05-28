Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get "/api/v1/merchants/find", 'merchants#find'
  get "/api/v1/merchants/find_all", 'merchants#find_all'

  get '/api/v1/items/find', 'items#find'
  get '/api/v1/items/find_all', 'items#find_all'


  namespace :api do
    namespace :v1 do
      resources :merchants, only: [:index, :show]
      resources :items, only: [:index, :show, :create, :destroy, :update]
      get "/items/:id/merchant", to: 'items#merchant'
      get '/merchants/:id/items', to: 'merchants#items'
      get "/merchants/most_items", to: 'merchants#most_items'
    end
  end


  get "/api/v1/revenue/merchants/:id", to: 'revenues#merchant'
  get "/api/v1/revenue/merchants", to: 'revenues#most_profitable'

end
