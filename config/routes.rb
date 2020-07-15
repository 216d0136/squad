Rails.application.routes.draw do

  devise_for :users

  root 'homes#top'
  get 'homes/about'

  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users,only: [:show,:edit,:update,:index] do
  	resources :relationships, only: [:create, :destroy]
    get 'follows' => 'relationships#follower', as: 'follows'
    get 'followers' => 'relationships#followed', as: 'followers'
  end
  
  resources :teams, only: [:index, :show, :edit, :create, :update, :destroy] do
    resources :team_comments, only: [:create, :destroy]
    resources :favorites, only: [:create, :destroy]
  end
end
