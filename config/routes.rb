Rails.application.routes.draw do
  mount ActionCable.server => '/cable'
    get 'platforms/show'
    get 'home/index'
    resources :sessions, only: [:create, :destroy]
    resources :prices
    get '/platforms', to: 'platforms#index'
    get '/platforms/coin', to: 'platforms#fecth_coins_platform'
    get '/coins/price', to: 'prices#fetch_prices_coin'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
