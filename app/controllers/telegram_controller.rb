class TelegramController < Telegram::Bot::UpdatesController
  # include Telegram::Bot::UpdatesController::ReplyHelpers
  def start!(*)
    pp params
    #Telegram.bot.send_message(chat_id: message[:from][:id], text: "Hi #{message[:from][:first_name]}" )
  end

  private

  def message
    params.require(:message).permit(:text,from:[:id,:first_name,:language_code],entities:[:type])
  end
end

