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

  get 'retrospectives', to: 'retrospectives#index'
  get 'retrospectives/crops', to: 'retrospectives#crops', as: :retrospective_crops
  get 'retrospectives/garden', to: 'retrospectives#garden', as: :retrospective_garden
  get 'retrospectives/harvests', to: 'retrospectives#harvests', as: :retrospective_harvests
  get 'retrospectives/moisture', to: 'retrospectives#moisture', as: :retrospective_moisture

  get 'maintenance', to: 'maintenance#index'
  get 'maintenance/sensors', to: 'maintenance#sensors', as: :maintenance_sensors
  get 'maintenance/data_retention', to: 'maintenance#data_retention', as: :maintenance_data_retention
  post 'maintenance/summarize_moisture_readings',
       to: 'maintenance#summarize_moisture_readings',
       as: :maintenance_summarize_moisture_readings
  get 'maintenance/backups', to: 'maintenance#backups', as: :maintenance_backups
  get 'maintenance/notes', to: 'maintenance#notes', as: :maintenance_notes

  resources :zones
  resources :tanks
  resources :moisture_readings
  resources :crops do
    get 'split'
  end
  resources :events
  resources :notes

end
