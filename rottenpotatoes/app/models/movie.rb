class Movie < ActiveRecord::Base
  attr_accessible :title, :rating, :description, :release_date

  def self.all_ratings
    %w[G PG PG-13 NC-17 R]
  end

  class InvalidKeyError < StandardError
  end

  def self.find_in_tmdb(search_terms)
    Tmdb::Movie.find(search_terms)
  rescue Tmdb::InvalidApiKeyError
    raise Movie::InvalidKeyError, 'Invalid API key'
  end
end
