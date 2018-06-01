Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :charities, only: [:index, :show] do
    post "favorite", to: "charities#favorite", as: :favorite
    resources :donations, only: [:new, :create, :destroy ] do
      resources :payments, only: [:new, :create]
    end
  end

  resources :bookmarks, only: [:update, :destroy]
  resources :donations, only: [ :destroy ]
  get '/preferences', to: 'pages#preferences', as: :preferences
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/search', to: 'charities#search', as: 'search'
end
