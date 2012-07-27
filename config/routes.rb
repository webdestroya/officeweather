OfficeWeather::Application.routes.draw do
  resources :temp_readings, :only => [:create]

  root :to => 'pages#index'
end
