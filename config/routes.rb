Myflix::Application.routes.draw do
  get '/home', to: "videos#index", as: 'home'
  get '/videos/:id', to: "videos#show", as: 'video_show'

  resources :categories, only: [:new, :create, :show]

  get 'ui(/:action)', controller: 'ui'
end
