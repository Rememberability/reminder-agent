ReminderAgent::Application.routes.draw do
  devise_for :users
  root to: "home#index"

  resources :users
  resources :items do
    member do
      post "remember"
      post "forget"
    end
  end
end
