Rails.application.routes.draw do
  devise_for :users
  root 'home#index'
  devise_for :admins

  namespace :admin do
    resources :payment_methods
  end

  namespace :user do
    resources :companies, only: %i[new create show edit update] do
      put 'token_generator', on: :member
    end
  end
end
