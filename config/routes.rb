require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'

  resources :products

  get "cart" => "carts#show", as: :cart
  post "cart/add_item" => "carts#add_item", as: :add_item
  delete "cart/:product_id" => "carts#remove_item", as: :remove_item

  get "up" => "rails/health#show", as: :rails_health_check

  root "rails/health#show"
end
