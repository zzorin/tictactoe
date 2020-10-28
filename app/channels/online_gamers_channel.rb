class OnlineGamersChannel < ApplicationCable::Channel
  def subscribed
    logger.info "OnlineGamersChannel => subscribed"
    # stream_for current_user
    current_user.appear(11)
    stream_for current_user
  end

  def unsubscribed
    current_user.disappear
  end

  def appear(data)
    current_user.appear(on: data['appearing_on'])
  end

  def away
    current_user.away
  end

  def create_game(data)
    # ActionCable.server.broadcast 'OnlineGamersChannel', '1'
    User.all.each do |listener|
      OnlineGamersChannel.broadcast_to(listener, data['game_id'])
    end
  end
end
