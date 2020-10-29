class GameChannel < ApplicationCable::Channel
  def subscribed
    logger.info "AccessorsNewSessionsChannel => subscribed"
    stream_for current_user
  end

  def make_move(data)
    # ActionCable.server.broadcast 'OnlineGamersChannel', '1'
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
