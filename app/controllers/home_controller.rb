class HomeController < ApplicationController


  def index
    debugger
    MovieTool.discover_movies
    @movies = Movie.all
  end

end