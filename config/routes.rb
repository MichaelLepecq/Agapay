Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :charities, only: [:index, :show] do
    resources :payments, only: [:new, :create]
    post "favorite", to: "charities#favorite", as: :favorite
    post "dislike", to: "charities#dislike", as: :dislike
    resources :donations, only: [:new, :create, :destroy ]
  end
  resources :bookmarks, only: [:update, :destroy]
  resources :donations, only: [ :destroy ]
  resources :user_categories, only: [:update]

  get '/preferences', to: 'categories#index', as: :preferences
  get '/search', to: 'charities#search', as: 'search'
  get '/favorites', to: 'charities#user_charities_index', as: :favorites
end
