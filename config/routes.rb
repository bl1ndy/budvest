Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?

  devise_for :users

  root to: 'home#index'

  resources :wallets
  resources :categories
  resources :transactions
end
