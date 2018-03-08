class TelegramWebhookController < Telegram::Bot::UpdatesController
  include Telegram::Bot::UpdatesController::MessageContext
  include Telegram::Bot::UpdatesController::CallbackQueryContext
  context_to_action!

  # def message(message)
  #   respond_with :message, text: 'message'
  # end

  def start(*)
    save_context :age
    respond_with :message, text: ObeyBotFacade::start(from)
    respond_with :message, text: ObeyBot::age_question
  end

  def age(age = nil, *)
    if (Integer(age) rescue false)
      save_context :gender
      respond_with :message, text: ObeyBotFacade::set_age(age), reply_markup: ObeyBot.gender_keyboard
    else
      save_context :age
      edit_message :message, text: "Неверный формат. Повторите попытку."
    end
  end

  def gender_callback_query(data)
    if data == 'Муж' or data == "Жен"
      answer_callback_query 'cool'
    else
      answer_callback_query 'er'
    end
  end

  # def gender_waiting(gender = nil, *)
  #   if gender == "Муж" or gender == "Жен"
  #     respond_with :message, text: ObeyBotFacade::set_gender(gender), reply_markup: ObeyBot.skills_keyboard
  #   else
  #     save_context :gender_waiting
  #     respond_with :message, text: "Неверный формат. Повторите попытку.", reply_markup: ObeyBot.gender_keyboard
  #   end
  # end

end
