class TelegramWebhookController < Telegram::Bot::UpdatesController
  include Telegram::Bot::UpdatesController::Session
  include Telegram::Bot::UpdatesController::MessageContext

  def message(message)
    respond_with :message, text: message
  end

  def start(*)
    save_context :age_waiting
    respond_with :message, text: ObeyBotFacade::start(from) if from
  end

  context_handler :age_waiting do |*words|
    if (Integer(words[0]) rescue false)
      save_context :gender_waiting
      respond_with :message, text: ObeyBotFacade::set_age(words)
    else
      save_context :age_waiting
      respond_with :message, text: "Неверный формат. Повторите попытку."
    end
  end

  context_handler :gender_waiting do |*words|
    if false
      respond_with :message, text: ObeyBotFacade::set_gender(words)
    else
      save_context :gender_waiting
      respond_with :message, text: "Неверный формат. Повторите попытку."
    end
  end

end
