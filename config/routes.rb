Asc10Portal::Application.routes.draw do
  devise_for :users

  mount Bootsy::Engine => '/bootsy', as: 'bootsy'

  namespace :admin do
    resources :news_entries
    resources :pages
    resources :users, except: [:new, :create]
    resources :shoutbox_messages, only: [:destroy]
    
    resources :settings, only: [:index]
    resources :banner_images, only: [:new, :create, :destroy] do
      put :set_active, on: :member
    end
    
    root to: 'news_entries#index'
  end
  
  resources :news_entries, only: [:index, :show], path: '/news'
  resources :shoutbox_messages, only: [:create]
  
  resources :pages, only: [:show]
  
  root to: 'news_entries#index'
end
