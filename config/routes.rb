Rails.application.routes.draw do
  root 'home#index'
  devise_for :users

  namespace :api do
    namespace :v1 do
      resources :contacts, only: [:index, :show, :create]
    end
  end
  # Serve websocket cable requests in-process
  # mount ActionCable.server => '/cable'
end
