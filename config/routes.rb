Rails.application.routes.draw do
  devise_for :users
  root to: 'links#index'

  resources :links, except: :index do
    resources :comments, only: [:create, :edit, :update, :destroy]
  end

  resources :comments, only: [:index]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
