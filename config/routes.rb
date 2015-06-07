ReminderAgent::Application.routes.draw do
  mount ItemsAPI => '/api'

  root to: "home#index"

  resources :users, only: %w[show]
  resources :items do
    member do
      put "remember"
      put "forget"
    end
  end

  get '/auth/:provider/callback' => 'sessions#create'
  get '/signin' => 'sessions#new', :as => :signin
  get '/signout' => 'sessions#destroy', :as => :signout
  get '/auth/failure' => 'sessions#failure'
end
