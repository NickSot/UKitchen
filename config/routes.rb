Rails.application.routes.draw do
  get 'families/index' => 'families#index'
  get 'families/new' => 'families#new'
  get 'families/edit/:id' => 'families#edit'
  get 'families/show/:id' => 'families#show'
  post 'families/new' => 'families#create'
  patch 'families/edit/:id' => 'families#update'
  

  # FAMILY MEMBERS MANAGEMENT
  get 'families/add_members/:family_id' => 'families#add_members', as: 'add_members'
  get 'families/do_add_member/:user_id/:family_id' => 'families#do_add_member'
  get 'families/:family_id/kick/:user_id' => 'families#kick', as: "family_kick"
  get 'families/search' => 'families#search'
  get 'families/edit_budget/:family_id' => 'families#edit_budget'
  patch 'families/do_edit_budget/:family_id' => 'families#do_edit_budget'


  get 'families/:family_id/shopping_lists/new' => 'shopping_lists#new'
  post 'families/:family_id/shopping_lists/new' => 'shopping_lists#create'
  get 'families/:family_id/shopping_lists/:id' => 'shopping_lists#index', as: 'shopping_list'
  get 'families/:family_id/shopping_lists/:id/edit' => 'shopping_lists#edit'
  post 'families/:family_id/shopping_lists/:sl_id/add_item/:item_id' => 'shopping_lists#add_item'
  delete 'families/:family_id/shopping_lists/:sl_id/:item_id' => 'shopping_lists#delete_item', as: "delete_item"
  patch 'families/:family_id/shopping_lists/:sl_id/buy/:item_id' => "shopping_lists#buy_item", as: "buy_item"

  resources :users
  # SESSION MANAGEMENT
  get 'login', to: 'session#new', as: "login" 
  post 'login', to: 'session#create'
  get 'logout', to: 'session#destroy', as: 'logout' 
  get 'register', to: 'users#new', as: 'register'

  #COOKING MANAGEMENT
  get 'recipes/family', to: 'recipes#index'
  get 'recipes/family/:family_id', to: 'recipes#index', as: "recipes"
  get 'recipes/family/:family_id/search', to: 'recipes#search_recipes'
  get 'recipes/family/:family_id/:id', to: 'recipes#show', as: "recipe"
  get 'recipes/family/:family_id/:id/add' => 'recipes#add'
  post 'recipes/family/:family_id/:id/add' => 'recipes#add_ingredient'

  # root 'users#index'
  root 'welcome#show', as: 'root'
end
