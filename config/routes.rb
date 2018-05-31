Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :charities, only: [:index, :show] do
    post "favorite", to: "charities#favorite", as: :favorite
    resources :donations, only: [:create ] do
      resources :payments, only: [:new, :create]
    end
    # resources :bookmarks, only: [:create]
  end
  # resources :bookmarks, only: [:update, :destroy]
  resources :donations, only: [ :destroy ]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end


# cliquer sur le coeur
# lien vers une action favorite dans le controleur charity
# creer un objet user_charity pour cette charite
# on va ajouter en js une classe liked a notre coeur (colirse)
