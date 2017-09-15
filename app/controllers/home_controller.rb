class HomeController < ApplicationController


  def index
    MovieTool.discover_movies
    @movies = Movie.all
  end

end