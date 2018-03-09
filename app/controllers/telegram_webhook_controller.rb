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
      respond_with :message, text: ObeyBot.say_error
    end
  end

  def gender(data = nil, *)
    data.downcase!
    if [ObeyBot.vars[:man_gender_var], ObeyBot.vars[:woman_gender_var]].include? data
      save_context :skill_level
      respond_with :message, text: ObeyBotFacade.gender_answer(data)
      respond_with :message, text: ObeyBot.skills_level_question
    else
      save_context :gender
      respond_with :message, text: ObeyBot.say_error
    end
  end

  def skill_level(data = nil, *)
    data.downcase!
    if [ObeyBot.vars[:low_skill_level_var], ObeyBot.vars[:medium_skill_level_var], ObeyBot.vars[:high_skill_level_var]].include? data
      respond_with :message, text: ObeyBotFacade.skill_level_answer(data)
    else
      save_context :skill_level
      respond_with :message, text: ObeyBot.say_error
    end
  end

end
