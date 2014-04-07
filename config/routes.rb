WhatsHapp::Application.routes.draw do
  resources :subscriptions, only: [:create]
  resources :incoming_messages, only: [:create]
  resources :events, only: [:index]

  root to: 'subscriptions#new'
end
