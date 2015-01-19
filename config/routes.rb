Myflix::Application.routes.draw do
  root to: 'pages#front'

  get '/register', to: 'users#new'

  get '/sign_in', to: 'sessions#new'
  post '/sign_in', to: 'sessions#create'
  get '/sign_out', to: 'sessions#destory'

  resources :users, only: [:create]

  get '/home', to: "videos#index", as: 'home'

  resources :videos, only: [:show] do
    collection do
      get 'search'
    end
  end

  resources :categories, only: [:new, :create, :show]

  get 'ui(/:action)', controller: 'ui'
end
