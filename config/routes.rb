Rails.application.routes.draw do
  get 'sessions/new'
  root 'tasks#index'
  resources :tasks
  resources :users, only: [:new, :create, :show]#:edit, :update足したい
  resources :sessions, only: [:new, :create, :destroy]
end