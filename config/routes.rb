Rails.application.routes.draw do
  root 'home#index'
  devise_for :admins
  devise_for :users

  namespace :admin do
    resources :payment_methods
    resources :companies, only: %i[index show edit update] do
      put 'token_generator', on: :member
    end
  end

  namespace :user do
    resources :payment_methods, only: %i[index show] do
      resources :boleto_methods, only: %i[new create edit update destroy]
      resources :pix_methods, only: %i[new create edit update destroy]
      resources :card_methods, only: %i[new create edit update destroy]
    end
    resources :companies, only: %i[new create show edit update] do
      put 'token_generator', on: :member
      resources :products, only: %i[index show]
    end
  end
end
