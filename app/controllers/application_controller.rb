require 'unirest'

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def index
    discover_movies
    @movies = Movie.all
    render template: 'layouts/application'
  end

  def latest_movie
    latest_movie = Unirest.get "https://api.themoviedb.org/3/movie/latest?api_key=2608d6a6f0be2798af1efddc7009cc8a"
    movie = Movie.where.has { title == latest_movie.body["title"] }.first_or_initialize
    movie.overview = latest_movie.body["overview"]
    movie.save
    movie
  end

  def discover_movies
    discover_movies = Unirest.get "https://api.themoviedb.org/3/discover/movie?sort_by=popularity.desc&api_key=2608d6a6f0be2798af1efddc7009cc8a"
    discover_movies.body["results"].each do |discover_movie|
      movie = Movie.where.has { title == discover_movie["title"] }.first_or_initialize
      #movie.overview = discover_movie["overview"]
      %w(overview adult vote_count popularity poster_path backdrop_path original_language original_title release_date).each do |attr|
        movie.send("#{attr}=", discover_movie[attr])
      end
      movie.save
    end
  end
end
