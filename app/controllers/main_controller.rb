class MainController < ApplicationController

  def search

    #@movies = Movie.ransack(title: params[:q]).result(distinct: true)
    #@movies = Movie.where.has { title == params[:q] }.result(distinct: true)
    @movies = Movie.where(title: params[:q])


    respond_to do |format|
      format.html {}
      format.json {
        @movies = @movies.limit(5)
      }
    end
  end
end