Rails.application.routes.draw do
  root 'home#index'
  devise_for :users

  resources :home, only: :index do
    collection do
      get 'contacts'
    end
  end

  resources :deals do
    member do
      post :add_attachment
    end
  end

  resources :tasks
  resource :user_management, only: [:show] do
    post '/:user_id/make_admin', action: :make_admin, as: :make_admin
    delete '/:user_id/remove', action: :remove_user, as: :remove_user
  end

  namespace :api do
    namespace :v1 do
      resources :contacts, only: [:index, :show, :create, :update, :destroy]
      resources :deals, only: [:index, :create]
    end
  end
  # Serve websocket cable requests in-process
  # mount ActionCable.server => '/cable'
end
