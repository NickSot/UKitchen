Rails.application.routes.draw do
  # get 'families/index' => 'families#index'
  get 'families/new' => 'families#new'
  get 'families/edit/:id' => 'families#edit'
  get 'families/show/:id' => 'families#show'
  post 'families/new' => 'families#create'
  patch 'families/edit/:id' => 'families#update'
  get 'families/add_member/:user_id' => 'families#add_member'
  get 'families/do_add_member/:user_id/:family_id' => 'families#do_add_member'
  
  get 'families/:family_id/shopping_lists/new' => 'shopping_lists#new'
  post 'families/:family_id/shopping_lists/new' => 'shopping_lists#create'
  get 'families/:family_id/shopping_lists/:id' => 'shopping_lists#index'
  get 'families/:family_id/shopping_lists/:id/edit' => 'shopping_lists#edit'

  get 'users/show/:id' => 'users#show'
  
  resources :users
  
  get 'login', to: 'session#new', as: "login" 
  post 'login', to: 'session#create'
  get 'logout', to: 'session#destroy', as: 'logout' 
  get 'register', to: 'users#new', as: 'register'
  
  # root 'users#index'
  root 'welcome#show', as: 'root'
end
