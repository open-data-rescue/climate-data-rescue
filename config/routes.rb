Weather::Application.routes.draw do



  resources :content_images

  match "content_images/:id/delete" => "content_images#destroy", via: [:get, :delete], as: 'delete_content_image'

  resources :ledgers


  resources :transcriptions


  resources :annotations


  resources :page_types


  resources :pages
  # post 'pages' => 'pages#create', as: "pages_create"


  resources :page_types

  resources :field_options


  resources :fields

  resources :field_groups

  devise_for :users, :controllers => {:registrations => "registrations"}
  resources :users, except: [:create, :new]

  # Name it however you want

  root :to => "home#index"
  match 'home' => 'home#index', :via => [:get, :post]
  get 'transcribe(/:current_page_id)' => 'transcriptions#new', as: "transcribe_page"
  # match 'pagetypes' => 'pagetypes#index', :via => [:get, :post]
  match 'ledgers' => 'ledgers#index', :via => [:get, :post]
  match 'users/dismiss_box_tutorial' => 'users#dismiss_box_tutorial', :via => [:post]
  match 'users' => 'users#index', :via => [:get]
  match 'users/:id/profile' => 'users#show', :via => [:get], as: "user_profile"
  match 'users/:id/edit' => 'users#edit', :via => [:get, :post]
  match 'users/:id/stats' => 'users#stats', :via => [:get, :post]
  match 'new-user' => 'users#new', :via => [:get, :post]
  match 'fieldGroups' => 'fieldgroups#index', :via => [:get, :post]
  match 'fields' => 'fields#index', :via => [:get, :post]

  # for field options app
  get 'field_options_for_field/:field_id' => "field_options#for_field", as: "field_options_for_field"
  post 'add_field_option_to_field' => "field_options#add_to_field", as: "add_field_option_to_field"
  post 'remove_field_option_from_field' => "field_options#remove_from_field", as: "remove_field_option_from_field"
  post 'field_options/update_sort_order' => "field_options#update_sort_order", as: "update_field_option_sort_order"

  # for fields app
  get 'fields_for_field_group/:field_group_id' => "fields#for_field_group", as: "fields_for_field_group"
  post 'add_fields_to_field_group' => "fields#add_to_field_group", as: "add_field_to_field_group"
  post 'remove_fields_from_field_group' => "fields#remove_from_field_group", as: "remove_field_from_field_group"
  post 'fields/update_sort_order' => "fields#update_sort_order", as: "update_field_sort_order"
  
  # for fields app
  get 'field_groups_for_page_type/:page_type_id' => "field_groups#for_page_type", as: "field_groups_for_page_type"
  post 'add_field_groups_to_page_type' => "field_groups#add_to_page_type", as: "add_field_group_to_page_type"
  post 'remove_field_groups_from_page_type' => "field_groups#remove_from_page_type", as: "remove_field_group_from_page_type"
  post 'field_groups/update_sort_order' => "field_groups#update_sort_order", as: "update_field_group_sort_order"

  #match '/avatars/original/missing.png', :via => [:get, :post]

  post 'create_page_metadata' => "page_days#create"

  get 'my_transcriptions' => 'transcriptions#my_transcriptions', as: "my_transcriptions"
  get 'weather-logs' => 'pages#public_index', as: "public_pages_index"

  get "page_for_transcription/:transcription_id" => "pages#for_transcription"

  resources :static_pages
  constraints(StaticPage) do
    get '/(*path)', to: 'static_pages#show', as: 'static'
  end

  devise_scope :user do
    get "login", to: "devise/sessions#new"
    get "logout", to: "devise/sessions#destroy"
  end

end
