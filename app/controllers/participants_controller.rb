class ParticipantsController < ApplicationController
  load_and_authorize_resource

  def index
    @game = Game.find(params[:game_id])
    @participants = @game.participants.accessible_by(current_ability)
  end

  def by_user
    @game = Game.find(params[:game_id])
    @participant = @game.participants&.find_by(user_id: params[:user_id])
  end

  def show; end

  def create
    if @participant.save
      render :create
    else
      render :errors
    end
  end

  def update
    if @participant.update(participant_params)
      render :update
    else
      render :errors
    end
  end

  def destroy
    if @participant.destroy
      render :destroy
    else
      render :errors
    end
  end

  private
    def participant_params
      params.require(:participant)
            .permit(:user_id, :game_id, :role)
    end
end
