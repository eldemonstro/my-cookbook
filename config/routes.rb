Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'home#index'
  resources :recipes do
    post 'favorite', on: :member
    post 'unfavorite', on: :member
    post 'share', on: :member
  end

  get 'my_favorite_recipes', to: 'home#favorites', as: 'favorite_recipes'

  resources :cuisines, only: [:show, :new, :create, :edit, :update]
  resources :recipe_types, only: [:show, :new, :create, :edit, :update]
end
