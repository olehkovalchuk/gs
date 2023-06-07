
module Chat
  module ConversationAction
    extend self

    def after_create( model, form )
      model.sender_company.increment!(:chats_out_count)
      model.sender.increment!(:chats_out_count)
      model.recipient_company.increment!(:chats_in_count)
      model.recipient.increment!(:chats_in_count)
    end
    def before_destroy( model )
      # model.sender_company.decrement!(:chats_out_count)
      # model.sender.decrement!(:chats_out_count)
      # model.recipient_company.decrement!(:chats_in_count)
      # model.recipient.decrement!(:chats_in_count)
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



