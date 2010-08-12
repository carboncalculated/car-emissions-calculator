CarApp::Application.routes.draw do
  resources :car_calculators, :only => [:new, :create] do
    collection do
      post "get_fuel_types"
      post "get_models"
      post "get_cars"
    end
  end
  root :to => "car_calculators#new"
end
