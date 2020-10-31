class GameChannel < ApplicationCable::Channel
  def subscribed
    logger.info "AccessorsNewSessionsChannel => subscribed"
    stream_for current_user
  end

  def make_move(data)
    coordinates = data['coordinate'].split('_').map(&:to_i)
    current_game = Game.find_by_id(data['game_id'])
    current_move = current_game.moves.create(player: data['participant_role'], x: coordinates[0], y: coordinates[1])
    current_game.check_game_progress(current_move)
    # Move.create(game_id: data['game_id'], player: data['participant_role'], coordinate: data['coordinate'])
    User.all.each do |listener|
      GameChannel.broadcast_to(listener, data)
    end
  end

  def start_game(data)
    Game.find_by_id(data['game_id'])&.start!
    User.all.each do |listener|
      GameChannel.broadcast_to(listener, data)
    end
  end
end
