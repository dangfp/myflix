Myflix::Application.routes.draw do
  get '/home', to: "videos#index", as: 'home'

  resources :videos, only: [:show] do
    collection do
      get 'search'
    end
  end

  resources :categories, only: [:new, :create, :show]

  get 'ui(/:action)', controller: 'ui'
end
