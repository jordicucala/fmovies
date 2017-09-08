class MoviesController < ApplicationController

  def index
    @movies = Movie.paginate(:page => params[:page], :per_page => 10).order('title ASC')
  end
end