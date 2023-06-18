Rails.application.routes.draw do
  get 'pages/index'

  namespace :api do
    get 'truck_data/map'
  end

  root "pages#index"
end
