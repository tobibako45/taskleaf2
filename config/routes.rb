Rails.application.routes.draw do
  get '/login', to: 'session#new'
  post '/login', to: 'session#create'
  delete '/logout', to: 'session#destroy'

  namespace :admin do
    resources :users
  end

  root to: 'tasks#index'

  # resources :tasks
  resources :tasks do

    # new do
    #   post :confirm, action: :confirm_new
    # end

    # :onオプション
    post :confirm, action: :confirm_new, on: :new
  end

end
