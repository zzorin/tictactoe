class GamesChannel < ApplicationCable::Channel
  def subscribed
    logger.info "GamesChannel => subscribed"
    @game = Game.find(params[:game_id])
    stream_for @game
  end

  def make_move(data)
    coordinates = data['coordinate'].split('_').map(&:to_i)
    current_move = @game.moves.create(player: data['participant_role'], x: coordinates[0], y: coordinates[1])
    @game.reload.check_game_progress(current_move)
    data['game_state'] = @game.aasm_state
    data['game_winner'] = @game.winner
    GamesChannel.broadcast_to(@game, data)
  end

  def start_game(data)
    @game.start!
    GamesChannel.broadcast_to(@game, data)
  end
end
