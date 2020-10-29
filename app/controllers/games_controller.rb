class GamesController < ApplicationController
  load_and_authorize_resource

  def index; end

  def show; end

  def create
    if @game.save
      render :create
    else
      render :errors
    end
  end

  def update
    if @game.update(game_params)
      render :update
    else
      render :errors
    end
  end

  def destroy
    if @game.destroy
      render :destroy
    else
      render :errors
    end
  end

  private

    def game_params
      params.require(:game).permit(:size, :participant_id, participants_attributes: [:id, :user_id, :role])
    end
end
