class TelegramWebhookController < Telegram::Bot::UpdatesController
  include Telegram::Bot::UpdatesController::MessageContext
  context_to_action!
  use_session!

  # def message(message)

  #   respond_with  :message,
  #                 text: 'message'
  # end

  def start(*)
    respond_with  :message, text: ObeyBotFacade.start(from)
    self.age
  end

  def age(age = nil, *)

    if (Integer(age) rescue false)
      save_context  :gender
      respond_with  :message,
                    text: ObeyBotFacade.age_answer(age, from['id'])
      respond_with :message,
                    text: ObeyBot.gender_question,
                    reply_markup: ObeyBot.gender_keyboard

    else
      save_context  :age
      respond_with  :message,
                    text: ObeyBot.say_error

    end

  end

  def gender(data = nil, *)

    if [  ObeyBot.vars[:man_gender_var],
          ObeyBot.vars[:woman_gender_var]
    ].include? data
        save_context  :skill_level
        respond_with  :message,
                      text: ObeyBotFacade.gender_answer(data, from['id']),
                      reply_markup: ObeyBot.remove_keyboard
        respond_with  :message,
                      text: ObeyBot.skill_level_question,
                      reply_markup: ObeyBot.skills_keyboard

    else
      save_context  :gender
      respond_with  :message,
                    text: ObeyBot.say_error

    end

  end

  def skill_level(data = nil, *)

    if [  ObeyBot.vars[:low_skill_level_var],
          ObeyBot.vars[:medium_skill_level_var],
          ObeyBot.vars[:high_skill_level_var]
    ].include? data
        save_context  :show_program
        respond_with  :message,
                      text: ObeyBotFacade.skill_level_answer(data, from['id']),
                      reply_markup: ObeyBot.remove_keyboard
        respond_with  :message,
                      text: ObeyBot.user_program_text(from['id']),
                      reply_markup: ObeyBot.user_program_buttons(from['id'])

    else
      save_context  :skill_level
      respond_with  :message,
                    text: ObeyBot.say_error

    end

  end

  def show_program(data = nil, *)

    if TelegramWebhookControllerHelper::current_user(from['id']).program.trainings.pluck(:name).include? update["message"]["text"]
      self.show_training
    else
      save_context  :show_program
      respond_with  :message,
                    text: ObeyBot.user_program_text(from['id']),
                    reply_markup: ObeyBot.user_program_buttons(from['id'])

    end

  end

  def show_training(data = nil, *)

    if data == "Назад"
      save_context  :show_program
      respond_with  :message,
                    text: ObeyBot.user_program_text(from['id']),
                    reply_markup: ObeyBot.user_program_buttons(from['id'])

    elsif data == "Выполнил"
      save_context  :show_training
      respond_with  :message,
                    text: ObeyBot.training_done_text,
                    reply_markup: ObeyBot.remove_keyboard
      respond_with  :message,
                    text: ObeyBot.return_text,
                    reply_markup: ObeyBot.user_training_buttons(from['id'], data)

    else
      save_context  :show_training
      respond_with  :message,
                    text: ObeyBot.user_training_text(from['id'], update["message"]["text"]),
                    reply_markup: ObeyBot.user_training_buttons(from['id'], data)

    end

  end

end
