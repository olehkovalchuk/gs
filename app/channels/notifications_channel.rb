class NotificationsChannel < ApplicationCable::Channel
  def subscribed
    queue =  "notifications:#{current_user ? current_user.company_id : uniq_token }"
    stream_from queue
    ::Chat::NotificationOperation::Send.call(current_user: current_user)
  end

  def unsubscribed
    stop_all_streams
  end

end
