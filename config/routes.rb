Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :charities, only: [:index, :show] do
    resources :donations, only: [:create ] do
      resources :payments, only: [:new, :create]
    end
    resources :bookmarks, only: [:create]
  end
  get '/search', to: 'charities#search', as: 'search'
  resources :bookmarks, only: [:update, :destroy]
  resources :donations, only: [ :destroy ]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
