class ChatChannel < ApplicationCable::Channel
  # def subscribed
  #   stream_from current_user
  # end

  def subscribed
    stream_for current_user
  end

  def unsubscribed
  end
end
