class LoadDataController < ApplicationController
  # This endpoint is idempotent, failures can occur if the request to the external endpoints fail.
  def init
    MovieActorFetcher.run

    render json: { message: 'Sucessfully loaded Movie & Actor info'}, status: :created
  rescue Exception => e 
    render json: { message: e.message }, status: :internal_server_error
  end
end