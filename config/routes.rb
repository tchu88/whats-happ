WhatsHapp::Application.routes.draw do
  resources :subscriptions, only: [:create]
  resources :incoming_messages, only: [:create]

  root to: 'subscriptions#new'
end
