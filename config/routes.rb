Rails.application.routes.draw do
  mount ActionCable.server => '/cable'
    get 'platforms/show'
    get 'home/index'
    resources :prices
    get '/platforms', to: 'platforms#fetch_platforms'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
