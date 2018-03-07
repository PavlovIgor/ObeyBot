class TelegramWebhookController < Telegram::Bot::UpdatesController

  def message(message)
    respond_with :message, text: message
  end

  def start(*)
    respond_with :message, text: ObeyBotFacade::start(from) if from
  end


end
