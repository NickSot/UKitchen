Rails.application.routes.draw do
  get 'login', to: 'session#new', as: "login" 
  post 'login', to: 'session#create'
  get 'logout', to: 'session#destroy', as: 'logout' 
  resources :users
  root 'users#index', as: 'root'
end
