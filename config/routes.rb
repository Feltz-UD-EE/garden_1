Rails.application.routes.draw do

# Rodauth built-in paths are not defined here, and are not shown when doing
#   >rails routes
#
# public static & home routes
  root to: 'static#public_home'
  get 'public_home', to: 'static#public_home'
  get 'about', to: 'static#about'
  get 'credits', to: 'static#credits'
  get 'legal', to: 'static#legal'

  resources :zones
  resources :tanks
  resources :moisture_readings
  resources :crops
  resources :events

end
