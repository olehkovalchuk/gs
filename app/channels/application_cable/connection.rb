module ApplicationCable
  class Connection < ActionCable::Connection::Base

    identified_by :current_user
    attr_reader :uniq_token

    def connect
      self.current_user = user
      @uniq_token = cookies[:uniq_token]
    end

    protected
    def session
      cookies.encrypted[Rails.application.config.session_options[:key]]
    end

    def user
      return @user if @user
      @user = Signin.find_by_token(session["user_token"])&.signinable
    end
  end
end
