module MovieTool
  extend ActiveSupport::Concern

  def self.latest_movie
    latest_movie = Unirest.get "https://api.themoviedb.org/3/movie/latest?api_key=2608d6a6f0be2798af1efddc7009cc8a"
    movie = Movie.where.has { title == latest_movie.body["title"] }.first_or_initialize
    movie.overview = latest_movie.body["overview"]
    movie.save
    movie
  end

  def self.discover_movies
    discover_movies = Unirest.get "https://api.themoviedb.org/3/discover/movie?sort_by=popularity.desc&api_key=2608d6a6f0be2798af1efddc7009cc8a"
    discover_movies.body["results"].each do |discover_movie|
      movie = Movie.where.has { title == discover_movie["title"] }.first_or_initialize
      %w(overview adult vote_count popularity poster_path backdrop_path original_language original_title release_date).each do |attr|
        movie.send("#{attr}=", discover_movie[attr])
      end
      movie.save
    end
  end

  def self.popular_movies
    popular_movies = []
    discover_movies = Unirest.get "https://api.themoviedb.org/3/movie/popular?api_key=2608d6a6f0be2798af1efddc7009cc8a"
    discover_movies.body["results"].each do |discover_movie|
      movie = Movie.where.has { title == discover_movie["title"] }.first_or_initialize
      %w(overview adult vote_count popularity poster_path backdrop_path original_language original_title release_date).each do |attr|
        movie.send("#{attr}=", discover_movie[attr])
      end
      popular_movies << movie
    end
    popular_movies
  end

  def self.top_rates
    discover_movies = Unirest.get "https://api.themoviedb.org/3/discover/movie?sort_by=popularity.desc&api_key=2608d6a6f0be2798af1efddc7009cc8a"
    discover_movies.body["results"].each do |discover_movie|
      movie = Movie.where.has { title == discover_movie["title"] }.first_or_initialize
      %w(overview adult vote_count popularity poster_path backdrop_path original_language original_title release_date).each do |attr|
        movie.send("#{attr}=", discover_movie[attr])
      end
      movie.save
    end
  end

  def self.videos(movie_id)
    debugger
    videos = Unirest.get "https://api.themoviedb.org/3/movie/#{movie_id}/videos?api_key=2608d6a6f0be2798af1efddc7009cc8a"
  end
  
  def self.find_movie
    find_movie = 'https://api.themoviedb.org/3/movie/211672?api_key=2608d6a6f0be2798af1efddc7009cc8a'
    
  end


  module ClassMethods
  end
end