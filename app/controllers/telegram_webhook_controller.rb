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
      respond_with :message, text: ObeyBotFacade::set_age(words), reply_markup: ObeyBot.gender_keyboard
    else
      save_context :age_waiting
      respond_with :message, text: "Неверный формат. Повторите попытку."
    end
  end

  context_handler :gender_waiting do |*words|
    if words[0] == "Муж" or words[0] == "Жен"
      respond_with :message, text: ObeyBotFacade::set_gender(words[0]), reply_markup: ObeyBot.skills_keyboard
    else
      save_context :gender_waiting
      respond_with :message, text: "Неверный формат. Повторите попытку.", reply_markup: ObeyBot.gender_keyboard
    end
  end

end
