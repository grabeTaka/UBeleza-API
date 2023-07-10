Rails.application.routes.draw do
  use_doorkeeper

  #post '/custom/oauth/token' => 'tokens#create'

  scope :api do
    scope :v1 do
      devise_for :users, only: :registrations, controllers: {
        registrations: 'api/v1/user/registrations'
      }

      resources :products, controller: 'api/v1/products', only: [:index, :show]
      get "products_random" => "api/v1/products#random"

      resources :establishments, controller: 'api/v1/establishments', only: [:index, :show] do
        get "products" => "api/v1/products#by_establishment"
        get "schedulings" => "api/v1/scheduling#by_establishment"
      end

      get "establishments_random" => "api/v1/establishments#random"
      get "establisments/by_categories/:category_id" => "api/v1/establishments#by_categories"

      resources :categories, controller: "api/v1/categories", only: [:index, :show]
      resources :schedulings, controller: 'api/v1/scheduling', only: [:create]
      resources :subcategories, controller: 'api/v1/subcategories', only: [:index, :show]

      scope :private do
        resources :users, controller: 'api/v1/private/users', only: [:index, :create, :destroy, :show, :update]
        get 'current/user' => 'api/v1/private/users#current'
        get "users/get_by_role" => "api/v1/private/users#get_user_by_role"
        get "users/by_role/:role" => "api/v1/private/users#by_role"

        

        get "establishments_by_user/" => "api/v1/private/establishments#by_user"
        resources :establishments, controller: 'api/v1/private/establishments', only: [:create, :index, :destroy, :show, :update] do
          get "products" => "api/v1/products#by_establishment"
          patch "add_category" => "api/v1/private/category_types#add_category"
          patch "undo_category" => "api/v1/private/category_types#undo_category"
          get "users" => "api/v1/private/users#by_establishment"
          post "favorite_establishment" => "api/v1/private/establishments#favorite_establishment"
          resources :tables, controller: 'api/v1/private/tables', only: [:index, :create]
        end

        get "/establishments_by_favorite" => "api/v1/private/establishments#by_favorite"

        resources :shopping_cart, controller: 'api/v1/private/shopping_carts'
        resources :category_types, controller: 'api/v1/private/category_types'
        resources :products, controller: 'api/v1/private/products', only: [:create, :index, :destroy, :show, :update]

        resources :subcategories, controller: 'api/v1/private/subcategories', only: [:create, :destroy, :update]
        resources :scheduling, controller: 'api/v1/private/scheduling', only: [:create, :destroy, :update]
      end

    end
  end
end
