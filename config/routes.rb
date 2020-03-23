Rails.application.routes.draw do
  get 'pallets/scan'
  get 'pallets/nextlocation'
  # get 'pallets/:id/nextlocation'
  resources :pallets
  # resources :pallets do
  #   member do
  #     get 'nextlocation'
  #   end
  # end
# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'pallets#scan'
end
