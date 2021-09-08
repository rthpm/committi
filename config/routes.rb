Rails.application.routes.draw do
  resources :homes
  devise_for :users
end
