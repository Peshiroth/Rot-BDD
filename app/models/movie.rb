class Movie < ActiveRecord::Base
  attr_accessible :title, :rating, :description, :release_date, :director
  def self.all_ratings
    %w(G PG PG-13 NC-17 R)
  end

  def self.find_movies_by_director(director_name)
    self.where(director: director_name)
  end
end
