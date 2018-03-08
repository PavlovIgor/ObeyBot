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

  def age_waiting(age = nil, *)
    if (Integer(age) rescue false)
      save_context :gender_waiting
      respond_with :message, text: ObeyBotFacade::set_age(age), reply_markup: ObeyBot.gender_keyboard
    else
      save_context :age_waiting
      respond_with :message, text: "Неверный формат. Повторите попытку."
    end
  end

  def gender_waiting(gender = nil, *)
    if gender == "Муж" or gender == "Жен"
      respond_with :message, text: ObeyBotFacade::set_gender(gender), reply_markup: ObeyBot.skills_keyboard
    else
      save_context :gender_waiting
      respond_with :message, text: "Неверный формат. Повторите попытку.", reply_markup: ObeyBot.gender_keyboard
    end
  end


end
