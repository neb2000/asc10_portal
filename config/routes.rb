Asc10Portal::Application.routes.draw do
  devise_for :users

  mount Bootsy::Engine => '/bootsy', as: 'bootsy'

  namespace :admin do
    resources :news_entries
    resources :pages
    
    root to: 'news_entries#index'
  end
  
  resources :news_entries, only: [:index, :show], path: '/news'
  resources :shoutbox_messages, only: [:index, :create]
  
  resources :pages, only: [:show]
  
  root to: 'news_entries#index'
end
