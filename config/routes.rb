Rails.application.routes.draw do
  devise_for :users
  root to: 'links#index'

  resources :links, except: :index do
    resources :comments, only: [:create]
    member do
      post "upvote", to: "votes#upvote"
      post "downvote", to: "votes#downvote"
    end
  end

  resources :comments, only: [:index, :edit, :update, :destroy]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
