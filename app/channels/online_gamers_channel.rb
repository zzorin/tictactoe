class OnlineGamersChannel < ApplicationCable::Channel
  def subscribed
    logger.info "OnlineGamersChannel => subscribed"
    # stream_for current_user
    current_user.appear(11)
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
end
