require 'rails_helper'

describe MoviesController do

  describe '#create' do
    it 'should create a new movie' do
      my_movie = double('Movie', :title => 'Alien')
      expect(Movie).to receive(:create!).and_return(my_movie)
      post :create, :movie => my_movie
      expect(flash[:notice]).to match(/Alien was successfully created./)
      expect(response).to redirect_to(movies_path)
    end
  end

  describe '#update' do
    it 'should update the movie' do
      my_movie = double('Movie', :id => '1', :title => 'Alien')
      expect(Movie).to receive(:find).with('1').and_return(my_movie)
      expect(my_movie).to receive(:update_attributes!)
      put :update, :id => '1', :movie => my_movie
      expect(flash[:notice]).to match(/Alien was successfully updated./)
      expect(response).to redirect_to(movie_path(my_movie))
    end
  end

  describe '#delete' do
    it 'should delete the movie' do
      my_movie = double('Movie', :id => '1', :title => 'Alien')
      expect(Movie).to receive(:find).with('1').and_return(my_movie)
      expect(my_movie).to receive(:destroy)
      delete :destroy, :id => '1'
      expect(flash[:notice]).to match(/Movie 'Alien' deleted./)
      expect(response).to redirect_to(movies_path)
    end
  end

  describe '#similar_movies' do
    context 'when a director is found' do
      it "should return a list of movies with the same director" do
        my_movie = double('Movie', :id => '1', :title => 'Alien', :director => 'Spielberg')
        expect(Movie).to receive(:find).with('1').and_return(my_movie)
        expect(my_movie.director).to eql 'Spielberg'
        expect(Movie).to receive(:find_movies_by_director).with('Spielberg')
        get :similar_movies, {:id => 1}
      end
    end

    context 'when a director is not found' do
      it "should redirect to the home page" do
        my_movie = double('Movie', :id => '1', :title => 'Alien', :director => nil)
        expect(Movie).to receive(:find).with('1').and_return(my_movie)
        get :similar_movies, {:id => "1"}
        expect(flash[:notice]).to match(/'Alien' has no director info/)
        expect(response).to redirect_to(movies_path)
      end
    end
  end

end
