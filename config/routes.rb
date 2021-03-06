Asc10Portal::Application.routes.draw do  
  devise_for :users, controllers: { registrations: :registrations, sessions: :sessions }

  namespace :admin do
    resources :news_entries
    resources :pages
    resources :users, except: [:new, :create]
    resources :shoutbox_messages, only: [:index, :destroy]
    
    resources :recruitments, only: [:index, :edit, :update]
    
    resources :settings, only: [:index]
    
    resources :system_settings, only: [:edit, :update]
    resources :banner_images, only: [:new, :create, :destroy] do
      put :set_active, on: :member
    end
    
    namespace :forums do
      resources :categories
      resources :boards      
    end
    
    root to: 'news_entries#index'
  end
  
  namespace :forums do
    resources :categories, only: [:index, :show]
    
    resources :boards, only: [:index, :show] do
      resources :topics
    end
    
    resources :topics, only: [] do
      member do
        put :toggle_hide
        put :toggle_lock
        put :toggle_pin
        put :toggle_archive
      end
      resources :posts
    end
    root to: 'boards#index'
  end
  
  resources :news_entries, only: [:index, :show], path: '/news'
  resources :shoutbox_messages, only: [:create] do
    get :ajax_get_messages, on: :collection
  end
  
  resources :pages, only: [:show]
  
  resources :users, only: [:show] do
    get :ajax_get_users, on: :collection
  end
  
  resources :application_forms, only: [:new, :create], path: '/apply', path_names: { new: '' }
  resources :messages, except: [:edit, :update] do
    collection do
      get  :sent
      get  :deleted
      post :create_reply
    end
    member do
      put :restore
      put :mark_as_read, action: 'mark_read_unread',   read: true
      put :mark_as_unread, action: 'mark_read_unread', read: false
      get :reply
    end
  end
  
  resources :searches, path: '/search', only: [:index] do
    get :ajax_get_results, on: :collection
  end
  
  resource :roster, only: [:show] do
    get :ajax_get_roster, on: :member
  end
  
  resource :progression, only: [] do
    get :ajax_get_progression, on: :member
  end
  
  resource :sitemap, only: [:show]
  
  root to: 'news_entries#index'
end
