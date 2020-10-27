class GameChannel < ApplicationCable::Channel
  def subscribed
    logger.info "AccessorsNewSessionsChannel => subscribed"
    stream_for current_user
  end
end
