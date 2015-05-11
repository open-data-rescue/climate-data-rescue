Weather::Application.routes.draw do
  


  resources :collection_groups


  resources :transcriptions


  resources :annotations


  resources :asset_collections


  resources :assets


  resources :templates


  resources :entities


  resources :fields

  devise_for :users #, :path => 'u'
  resources :users, except: [:create, :new]

  # Name it however you want
  post 'create_user' => 'users#create', as: :create_user

  root :to => "home#index"
  match 'about' => 'home#about', :via => [:get, :post]
  match 'transcribe' => 'transcriptions#new', :via => [:get, :post]
  match 'collections' => 'asset_collections#index', :via => [:get, :post]
  match 'collectiongroups' => 'collection_groups#index', :via => [:get, :post]
  match 'users' => 'users#index', :via => [:get, :post]
  match 'users/:id' => 'users#show', :via => [:get, :post, :put]
  match 'users/:id/edit' => 'users#edit', :via => [:get, :post]
  match '/assets/:id/template' => 'assets#show', :via => [:get, :post]
  match 'new-user' => 'users#new', :via => [:get, :post]
  match 'fieldGroups' => 'entities#index', :via => [:get, :post]
  match 'fields' => 'fields#index', :via => [:get, :post]
  #match '/avatars/original/missing.png', :via => [:get, :post]
  resources :albums do
    
  end
  
  resources :photos

  devise_scope :user do
    get "login", to: "devise/sessions#new"
    get "logout", to: "devise/sessions#destroy"
  end

end
