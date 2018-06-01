Rails.application.routes.draw do
  get 'preferences/index'
  get 'preferences/new'
  get 'preferences/create'
  get 'preferences/update'
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
  get '/preferences', to: 'categories#index', as: :preferences
  resources :user_categories, only: [:update]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/search', to: 'charities#search', as: 'search'
end
