require 'unirest'

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def index
    @movies = Movie.all
    render template: 'layouts/application'
  end

end
