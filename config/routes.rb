Rails.application.routes.draw do
  root 'home#index'
  devise_for :users

  # Serve websocket cable requests in-process
  # mount ActionCable.server => '/cable'
end
