Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :charities, only: [:index, :show] do
    post "favorite", to: "charities#favorite", as: :favorite
    resources :donations, only: [:create, :destroy ] do
      resources :payments, only: [:new, :create]
    end
  end
  get '/search', to: 'charities#search', as: 'search'
end
