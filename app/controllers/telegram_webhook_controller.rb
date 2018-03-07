class TelegramWebhookController < Telegram::Bot::UpdatesController

  # def message(message)
  #   respond_with :message, text: message['text']
  # end

  def start(*)
    respond_with :message, text: ObeyBotFacade.welcome_text(from) if from
  end


end
