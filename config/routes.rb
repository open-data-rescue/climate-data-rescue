Scribe::Application.routes.draw do
  resources :templates
  
  resources :assets do
    resource :template
  end
    
  resources :annotations
  
  resources :asset_collections
  
  resources :transcriptions do
    collection do
      post :add_entity
    end
  end
  
  match 'transcribe' => "transcriptions#new", :via => [:get, :post]
  match 'about' => 'home#about', :via => [:get, :post]
  
  root :to => 'home#index'
end
