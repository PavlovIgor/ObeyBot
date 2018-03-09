class TelegramWebhookController < Telegram::Bot::UpdatesController
  include Telegram::Bot::UpdatesController::MessageContext
  context_to_action!

  # def message(message)
  #   respond_with :message, text: 'message'
  # end

  # def keyboard(value = nil, *)
  #   if value
  #     respond_with :message, text: value, reply_markup: ObeyBot.remove_keyboard
  #   else
  #     save_context :keyboard
  #     respond_with :message, text: 'ok', reply_markup: ObeyBot.gender_keyboard
  #   end
  # end

  def start(*)
    save_context :age
    respond_with :message, text: ObeyBotFacade.start(from)
    respond_with :message, text: ObeyBot.age_question
  end

  def age(age = nil, *)
    if (Integer(age) rescue false)
      save_context :gender
      respond_with :message, text: ObeyBotFacade.age_answer(age, update["message"]['from']['id'])
      respond_with :message, text: ObeyBot.gender_question, reply_markup: ObeyBot.gender_keyboard
    else
      save_context :age
      respond_with :message, text: ObeyBot.say_error
    end
  end

  def gender(data = nil, *)
    data.downcase!
    if [ObeyBot.vars[:man_gender_var], ObeyBot.vars[:woman_gender_var]].include? data
      save_context :skill_level
      respond_with :message, text: ObeyBotFacade.gender_answer(data, update["message"]['from']['id']), reply_markup: ObeyBot.remove_keyboard
      respond_with :message, text: ObeyBot.skill_level_question, reply_markup: ObeyBot.gender_keyboard
    else
      save_context :gender
      respond_with :message, text: ObeyBot.say_error
    end
  end

  def skill_level(data = nil, *)
    data.downcase!
    if [ObeyBot.vars[:low_skill_level_var], ObeyBot.vars[:medium_skill_level_var], ObeyBot.vars[:high_skill_level_var]].include? data
      respond_with :message, text: ObeyBotFacade.skill_level_answer(data, update["message"]['from']['id'])
      respond_with :message, text: ObeyBotFacade.user_program(update["message"]['from']['id']), reply_markup: ObeyBot.skills_keyboard
    else
      save_context :skill_level
      respond_with :message, text: ObeyBot.say_error
    end
  end

end
