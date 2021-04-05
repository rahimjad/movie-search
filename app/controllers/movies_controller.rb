class MoviesController < ApplicationController
  def show
    movies = Movie.where(id: show_params[:ids])
    
    render json: movies.as_json(include: :actors), status: :ok
  end

  private

  def show_params
    params.permit(:ids => [])
  end
end