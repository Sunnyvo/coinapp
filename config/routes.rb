Rails.application.routes.draw do
  mount ActionCable.server => '/cable'
    get 'platforms/show'
    get 'home/index'
    resources :prices
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
