Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :charities, only: [:index, :show] do
    resources :donations, only: [:new, :create] do
      resources :payments, only: [:new, :create]
    end
    resources :bookmarks, only: [:create]
  end
  resources :bookmarks, only: [:update, :destroy]
  resources :donations, only: [ :destroy ]
  get '/preferences', to: 'pages#preferences', as: :preferences
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
