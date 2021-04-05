# frozen_string_literal: true

require 'net/http'

module MovieActorFetcher
  ACTORS_URL = "https://0zrzc6qbtj.execute-api.us-east-1.amazonaws.com/kinside/actors"
  MOVIES_URL = "https://0zrzc6qbtj.execute-api.us-east-1.amazonaws.com/kinside/movies"
  ACTOR_COLUMNS = [:id, :first_name, :last_name].freeze
  MOVIE_COLUMNS = [:id, :title, :year, :runtime, :genres, :director, :plot, :posterUrl, :rating, :pageUrl].freeze

  # I'm using a bulk importer here, this will add all records and will provide idempotency based on the conflict target. 
  # For actors and movies, if any details change in the columns outlined above (i.e anything other than id), the 
  # record will be updated. For the join table, any duplicates will be ignored.
  def self.run
    # bulk import actor details, maintains the ID from the payload
    actors_req = Net::HTTP.get(URI.parse(ACTORS_URL))
    actors_pyld = JSON.parse(actors_req, symbolize_names: true)
    Actor.import(
      ACTOR_COLUMNS, 
      actors_pyld, 
      on_duplicate_key_update: { conflict_target: [:id] }
    )

    # bulk import movie details, maintains the ID from the payload
    movies_req= Net::HTTP.get(URI.parse(MOVIES_URL))
    movies_pyld = JSON.parse(movies_req, symbolize_names: true)
    Movie.import( 
      MOVIE_COLUMNS,
      movies_pyld,
      on_duplicate_key_update: { conflict_target: [:id] }
    )

    # creates records in the join table for querying later
    movie_actors = movies_pyld.flat_map do |mv|
      mv[:actorIds].map {|id| { actor_id: id, movie_id: mv[:id] }}
    end 
    MovieActor.import(
      movie_actors, 
      on_duplicate_key_ignore: { conflict_target: [:actor_id, :movie_id] }
    )
  end
end