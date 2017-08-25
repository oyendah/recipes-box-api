Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  scope module: :v1, constraints: ApiVersion.new('v1', true) do
    resources :users do
      resources :recipes
    end
    post 'signup', to: 'users#create'
    get  'recipes', to: 'all_recipe#index'
    get  'recipes/:id', to: 'all_recipe#show'
  end
  post 'login', to: 'authentication#authenticate'
end
