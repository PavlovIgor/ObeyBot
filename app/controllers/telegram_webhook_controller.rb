class TelegramWebhookController < Telegram::Bot::UpdatesController

  def message(message)
    respond_with :message, text: message
  end

  def start(*)
    respond_with :message, text: from
  end


end
