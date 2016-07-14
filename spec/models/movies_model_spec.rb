require 'rails_helper'

describe Movie do
  describe '#find_movies_by_director' do
    it 'should search for movies with the same director' do
      movie = double('Movie', :director => 'Spielberg')
      expect(Movie).to receive(:where).with(director: 'Spielberg')
      Movie.find_movies_by_director('Spielberg')
    end
  end
end
