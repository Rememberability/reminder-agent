ReminderAgent::Application.routes.draw do
  mount ItemsAPI => '/api'

  devise_for :users
  root to: "home#index"

  resources :users
  resources :items do
    member do
      put "remember"
      put "forget"
    end
  end
end
