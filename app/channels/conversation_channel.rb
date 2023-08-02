class ConversationChannel < ApplicationCable::Channel
  def subscribed
    stream_from "conversation_channel_#{current_user.id}"
  end

  def unsubscribed
  end
end
