
module Chat
  module ContactAction
    extend self

    def after_create( model, form )
      Admin::User.all.each do |user|
        Admin::UserMailer.notify( "New notification from #{model.name} #{model.email}", model.text, user ).send(Rails.env.development? ? :deliver_now : :deliver_later )
      end
    end

    # Available callbacks methods
    # after_save
    # before_save
    # after_create
    # before_create
    # after_destroy
    # before_destroy
    # after_update
    # before_update
  end
end



