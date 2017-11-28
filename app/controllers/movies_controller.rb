class MoviesController < ApplicationController

  def index
    @movies = Movie.paginate(:page => params[:page], :per_page => 20).order('title ASC')
  end

  def now_playing
    #debugger
    #puts 'entra'
  end

  def show
    @movie = Movie.find(params[:id])
    @casts = Cast.search_cast_movie(params[:id])
  end
end