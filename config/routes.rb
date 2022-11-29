# here we define the urls for the controllers
Rails.application.routes.draw do

  authenticate :user do
    namespace :api do
      namespace :v1 do
        resources :pages, only: %i[index], path: 'page'
        resources :page_types, only: %i[index],  path: 'page_type'
        resources :transcriptions, only: %i[index],  path: 'transcription'
      end
    end
  end

  namespace :better_together, path: '/' do
    resources :posts, only: %i(index show)
  end
  filter :locale

  namespace :admin do
    namespace :better_together, path: '/' do
      resources :posts
    end


    get '/' => 'admin#landing'
    resources :content_images
    match "content_images/:id/delete" => "content_images#destroy", via: [:get, :delete], as: 'delete_content_image'
    resources :field_groups
    resources :field_options
    # defines urls for fields controllers "resources" is a method to define ...
    resources :fields
    resources :ledgers
    resources :page_types
    resources :pages
    resources :static_pages
    resources :users

    match 'transcriptions/export' => 'transcriptions#export',
          via: %i[get post],
          as: 'export_transcriptions'

    resources :transcriptions

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
  end

  root :to => "home#index"

  resources :transcriptions do
    resources 'annotations',
      except: %i[new edit],
      defaults: { format: :json }
  end

  get 'transcribe(/:current_page_id)' => 'transcriptions#new', as: "transcribe_page"
  resources :annotations, defaults: { format: :json }


  resources :pages, only: [:show, :index]
  get 'pages' => 'pages#index', as: "public_pages_index"
  # post 'pages' => 'pages#create', as: "pages_create"

  resources :field_options, only: [:index]
  get 'field_options_for_field/:field_id' => "field_options#for_field", as: "field_options_for_field"

  resources :fields, only: [:index]

  resources :field_groups, only: [:index]

  devise_for :users, :controllers => {:registrations => "registrations"}
  resources :users, except: [:create, :new, :destroy, :index] do
    member do
      get :completed_transcriptions, to: 'transcriptions#completed_transcriptions_table'
    end
  end
  match 'users/dismiss_box_tutorial' => 'users#dismiss_box_tutorial', :via => [:post]
  get 'my-profile' => 'users#show', as: "my_profile"
  get 'my-profile/certificate' => 'users#my_certificate', as: 'my_certificate'

  post 'create_page_metadata' => 'page_days#create'

  scope path: 'page-metadata' do
    post 'create' => 'page_days#create'
    post 'update' => 'page_days#update'
  end

  resources :static_pages
  constraints(StaticPage) do
    get ':locale/(*path)', to: 'static_pages#show', as: 'static', format: false
  end

  # authenticate :user, lambda { |u| u.admin? } do
  #   # mount Sidekiq::Web => '/sidekiq'
  # end

  devise_scope :user do
    get "login", to: "devise/sessions#new"
    get "logout", to: "devise/sessions#destroy"
  end

end
