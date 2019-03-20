Rails.application.routes.draw do
  resources :users

  get 'login', to: 'session#new', as: "login" 
  post 'login', to: 'session#create'
  get 'logout', to: 'session#destroy', as: 'logout' 
  get 'register', to: 'users#new', as: 'register' 

  root 'users#index', as: 'root'
end
