class MoviesController < ApplicationController
  def show
    movies = Movie.where(id: show_params[:ids])
    
    # I went for basic rendering here, this could be abstracted out to a presenter
    render json: movies.as_json(include: :actors), status: :ok
  end

  private

  def show_params
    params.permit(:ids => [])
  end
end