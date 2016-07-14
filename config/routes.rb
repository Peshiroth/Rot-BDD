Rottenpotatoes::Application.routes.draw do
  resources :movies
#  resources :movies do
#    collection do
#      get 'similar_movies'
#    end
#  end
  # map '/' to be a redirect to '/movies'
  root :to => redirect('/movies')
  get 'movies/:id/similar_movies', to: 'movies#similar_movies', :as => :similar_movies
end
