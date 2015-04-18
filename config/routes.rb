Myflix::Application.routes.draw do
  root to: 'pages#front'

  get  '/sign_in',         to: "sessions#new"
  post '/sign_in',         to: "sessions#create"
  get  '/sign_out',        to: "sessions#destroy"
  get  '/register',        to: 'users#new'
  get  '/home',            to: "videos#index", as: 'home'
  get  '/my_queue',        to: "queue_items#index"
  post '/my_queue/update', to: "queue_items#update"

  resources :users,  only: [:create, :show] do
    get :following, on: :member
  end

  resources :videos, only: [:show] do
    get 'search', on: :collection

    resources :reviews, only: [:create]
  end

  resources :categories,    only: [:new, :create, :show]
  resources :queue_items,   only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]

  get 'ui(/:action)', controller: 'ui'
end

