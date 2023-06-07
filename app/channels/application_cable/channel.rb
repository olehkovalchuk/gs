module ApplicationCable
  class Channel < ActionCable::Channel::Base
    delegate :uniq_token, :current_user, to: :connection
    # dont allow the clients to call those methods
    protected :uniq_token, :current_user
  end
end
