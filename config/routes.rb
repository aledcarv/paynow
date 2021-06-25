Rails.application.routes.draw do
  root 'home#index'
  devise_for :admins
  devise_for :users

  namespace :admin do
    resources :payment_methods
    resources :companies, only: %i[index show edit update] do
      put 'token_generator', on: :member
    end
    resources :charges, only: %i[index show update]
  end

  namespace :user do
    resources :payment_methods, only: %i[index show] do
      resources :boleto_methods, only: %i[new create edit update destroy]
      resources :pix_methods, only: %i[new create edit update destroy]
      resources :card_methods, only: %i[new create edit update destroy]
    end
    resources :companies, only: %i[new create show edit update] do
      put 'token_generator', on: :member
      resources :products
    end
  end

  namespace :api do
    namespace :v1 do
      resources :final_clients, only: %i[create]
      resources :charges, only: %i[create]
    end
  end
end
