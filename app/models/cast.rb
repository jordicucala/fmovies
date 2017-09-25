class Cast < ApplicationRecord

  def self.search_cast_movie(movie_id)
    cast = Unirest.get "https://api.themoviedb.org/3/movie/#{movie_id}/credits?api_key=2608d6a6f0be2798af1efddc7009cc8a"
    casts = []
    cast.body['cast'].each do |cast_person|
      cast = Cast.where.has { (character == cast_person['character']) }.first_or_initialize
      %w(name character gender profile_path cast_id order).each do |attr|
        cast.send("#{attr}=", cast_person[attr])
      end
      cast.movie_id = movie_id
      cast.save
      casts << cast
    end
    casts
  end
end
