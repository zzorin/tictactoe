class OnlineGamersChannel < ApplicationCable::Channel
  def subscribed
    logger.info "OnlineGamersChannel => subscribed"
    stream_from "OnlineGamersChannel"
  end

  def create_game(data)
    ActionCable.server.broadcast("OnlineGamersChannel", data)
  end

  def close_game(data)
    ActionCable.server.broadcast("OnlineGamersChannel", data)
  end
end
