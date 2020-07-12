Rails.application.routes.draw do
  root 'homes#top'
  get 'homes/about'

  devise_for :users
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users,only: [:show,:edit,:update,:index] do
  	resource :relationships, only: [:create, :destroy]
    get 'follows' => 'relationships#follower', as: 'follows'
    get 'followers' => 'relationships#followed', as: 'followers'
  end
  
  resources :teams, only: [:index, :show, :edit, :create, :update, :destroy] do
    resource :team_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end
end
