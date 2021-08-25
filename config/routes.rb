Rails.application.routes.draw do
  get 'cards/new'
  get 'users/show'
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  devise_scope :user do
    get 'residence', to: 'users/registrations#new_residence'
    post 'residence', to: 'users/registrations#create_residence'
  end
  root to: "items#index"
  resources :items do
    resources :purchases, only: [:index, :create]
    collection do
      get 'search'
    end
  end
  resources :users, only: [:show, :update]
  resources :cards, only: [:new, :create]
end