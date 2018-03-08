class TelegramWebhookController < Telegram::Bot::UpdatesController
  include Telegram::Bot::UpdatesController::MessageContext
  context_to_action!

  # def message(message)
  #   respond_with :message, text: 'message'
  # end

  def start(*)
    save_context :age
    respond_with :message, text: ObeyBotFacade.start(from)
    respond_with :message, text: ObeyBot.age_question
  end

  def age(age = nil, *)
    if (Integer(age) rescue false)
      save_context :gender
      respond_with :message, text: ObeyBotFacade.age_answer(age)
      respond_with :message, text: ObeyBot.gender_question
    else
      save_context :age
      respond_with :message, text: "Неверный формат. Повторите попытку."
    end
  end

  def gender_waiting(gender = nil, *)
    if gender == "М" or gender == "Ж"
      respond_with :message, text: ObeyBotFacade.gender_answer(gender)
    else
      save_context :gender_waiting
      respond_with :message, text: "Неверный формат. Повторите попытку.", reply_markup: ObeyBot.gender_keyboard
    end
  end

end
