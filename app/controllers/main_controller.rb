class MainController < ApplicationController

  def search
    debugger
    #@movies = Movie.ransack(title: params[:q]).result(distinct: true)
    @movies = Movie.c {title == params[:q] }.result(distinct: true)

    respond_to do |format|
      format.html {}
      format.json {
        @movies = @movies.limit(5)
      }
    end
  end
end