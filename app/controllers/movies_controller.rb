class MoviesController < ApplicationController
  def show
    movies = Movie.where(id: show_params)
    
    render json: movies.as_json, status: :ok
  end

  private

  def show_params
    params.permit(:ids => [])
  end
end