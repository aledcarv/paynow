Rails.application.routes.draw do
  root 'home#index'
  devise_for :admins
  devise_for :users

  namespace :admin do
    resources :payment_methods
    resources :companies, only: %i[index show]
  end

  namespace :user do
    resources :companies, only: %i[new create show edit update] do
      put 'token_generator', on: :member
    end
  end
end
