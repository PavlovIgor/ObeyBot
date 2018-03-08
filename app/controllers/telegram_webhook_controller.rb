class TelegramWebhookController < Telegram::Bot::UpdatesController
  include Telegram::Bot::UpdatesController::MessageContext
  context_to_action!

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

  def gender_waiting(value = nil, *)
    if update['data'] == "Муж" or update['data'] == "Жен"
      respond_with :message, text: ObeyBotFacade::set_gender(update['data']), reply_markup: ObeyBot.skills_keyboard
    else
      save_context :gender_waiting
      respond_with :message, text: "Неверный формат. Повторите попытку.", reply_markup: ObeyBot.gender_keyboard
    end
  end

end
