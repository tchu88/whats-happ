WhatsHapp::Application.routes.draw do
  resources :incoming_messages, only: [:create]
  resources :events, only: [:index]

  post '/' => 'subscriptions#create', as: :subscriptions
  root to: 'subscriptions#new'
end
