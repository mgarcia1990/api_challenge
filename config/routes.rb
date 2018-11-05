Rails.application.routes.draw do
  devise_for :users

  namespace :v1 do
    resources :people do
      post :movies, on: :member
      get :movies_as_actor_actress, on: :member
      get :movies_as_director, on: :member
      get :movies_as_producer, on: :member
    end
    resources :movies do
      post :crew, on: :member
      get :casting, on: :member
      get :directors, on: :member
      get :producers, on: :member
    end
    delete 'people/:id/movies/:movie_id/role/:role', to: 'people#destroy_movie'
    delete 'movies/:id/crew/:person_id/role/:role', to: 'movies#destroy_person'
  end
end
