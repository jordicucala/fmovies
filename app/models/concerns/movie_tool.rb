module MovieTool
  extend ActiveSupport::Concern

  API_KEY = '2608d6a6f0be2798af1efddc7009cc8a'
  def self.latest_movie
    latest_movie = Unirest.get "https://api.themoviedb.org/3/movie/latest?api_key=#{API_KEY}"
    movie = Movie.where.has { title == latest_movie.body["title"] }.first_or_initialize
    movie.overview = latest_movie.body["overview"]
    movie.save
    movie
  end

  def self.discover_movies
    discover_movies = Unirest.get "https://api.themoviedb.org/3/discover/movie?sort_by=popularity.desc&api_key=#{API_KEY}"
    discover_movies.body["results"].each do |discover_movie|
      movie = Movie.where.has { title == discover_movie["title"] }.first_or_initialize
      %w(overview adult vote_count popularity poster_path backdrop_path original_language original_title release_date).each do |attr|
        movie.send("#{attr}=", discover_movie[attr])
      end
      movie.movie_id = discover_movie['id']
      movie.save
    end
  end

  def self.popular_movies
    popular_movies = []
    discover_movies = Unirest.get "https://api.themoviedb.org/3/movie/popular?api_key=#{API_KEY}"
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
    discover_movies = Unirest.get "https://api.themoviedb.org/3/discover/movie?sort_by=popularity.desc&api_key=#{API_KEY}"
    discover_movies.body["results"].each do |discover_movie|
      movie = Movie.where.has { title == discover_movie["title"] }.first_or_initialize
      %w(overview adult vote_count popularity poster_path backdrop_path original_language original_title release_date).each do |attr|
        movie.send("#{attr}=", discover_movie[attr])
      end
      movie.save
    end
  end

  def self.videos(movie_id)
    videos = Unirest.get "https://api.themoviedb.org/3/movie/#{movie_id}/videos?api_key=#{API_KEY}"
    return false unless videos.present?
    videos.body["results"].each do |video|
      movie_video = Video.where.has {(video_id == video["id"]) & (videoable_type == 'Movie')}.first_or_initialize
      %w(key name site size).each do |attr|
        movie_video.send("#{attr}=", video[attr])
      end
      movie_video.videoable = Movie.find_by(movie_id: movie_id)
      movie_video.video_type = video['type']
      movie_video.save
    end
  end
  
  def self.find_movie
    find_movie = 'https://api.themoviedb.org/3/movie/211672?api_key=2608d6a6f0be2798af1efddc7009cc8a'
    
  end


  module ClassMethods
  end
end