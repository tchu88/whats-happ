WhatsHapp::Application.routes.draw do
  resources :subscriptions, only: [:create]
  root to: 'subscriptions#new'
end
