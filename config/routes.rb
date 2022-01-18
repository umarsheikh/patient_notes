Rails.application.routes.draw do
  resources :goals
  resources :notes
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "notes#index"
end
