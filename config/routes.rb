Rails.application.routes.draw do
  devise_for :users
  root 'home#index'
  devise_for :admins

  namespace :admin do
    resources :payment_methods
  end
end
