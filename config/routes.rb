Rails.application.routes.draw do
  namespace :v1 do
    resources :people
    resources :movies
  end
end
