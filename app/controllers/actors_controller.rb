class ActorsController < ApplicationController
  def show
    actors = Actor.where(id: show_params[:ids])

    # I went for basic rendering here, this could be abstracted out to a presenter
    render json: actors.as_json(include: :co_actors), status: :ok
  end

  private

  def show_params
    params.permit(:ids => [])
  end
end