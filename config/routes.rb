Rails.application.routes.draw do
  resources :zones
  resources :tanks
  resources :moisture_readings
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  get 'public_home', to: 'static#public_home'
  get 'about', to: 'static#about'
  get 'credits', to: 'static#credits'
  get 'legal', to: 'static#legal'

  # Defines the root path route ("/")
  root to: 'static#public_home'

end
