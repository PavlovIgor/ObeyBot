class TelegramWebhookController < Telegram::Bot::UpdatesController
  include Telegram::Bot::UpdatesController::MessageContext
  context_to_action!
  use_session!

  def start(*)
      ObeyBotFacade.new_user(from)
      respond_with  :message,
                    text: ObeyBot.say_welcome(from)
      self.age
  end

  def age(age = nil, *)
      if (Integer(age) rescue false)
          ObeyBotFacade.set_age(age, from['id'])
          respond_with  :message,
                        text: ObeyBot.vars[:age_answer]
          self.gender
      elsif age.nil?
          save_context  :age
          respond_with  :message,
                        text: ObeyBot.vars[:age_question]
      else
          save_context  :age
          respond_with  :message,
                        text: ObeyBot.vars[:error]
      end
  end

  def gender(data = nil, *)
      if [  ObeyBot.vars[:man],
            ObeyBot.vars[:woman]
      ].include? data
          ObeyBotFacade.set_gender(data, from['id'])
          respond_with  :message,
                        text: ObeyBot.vars[:gender_answer],
                        reply_markup: ObeyBot.vars[:remove_keyboard]
          self.skill_level
      elsif data.nil?
          save_context  :gender
          respond_with :message,
                        text: ObeyBot.vars[:gender_question],
                        reply_markup: ObeyBot.gender_keyboard

      else
          save_context  :gender
          respond_with  :message,
                        text: ObeyBot.vars[:error]
      end
  end

  def skill_level(data = nil, *)
      if [  ObeyBot.vars[:low_skill],
            ObeyBot.vars[:medium_skill],
            ObeyBot.vars[:high_skill]
      ].include? data
          ObeyBotFacade.set_skill_level(data, from['id'])
          respond_with  :message,
                        text: ObeyBot.vars[:skill_level_answer],
                        reply_markup: ObeyBot.vars[:remove_keyboard]
          self.show_program

      elsif data.nil?
          save_context  :skill_level
          respond_with  :message,
                        text: ObeyBot.vars[:skill_level_question],
                        reply_markup: ObeyBot.skills_keyboard

      else
          save_context  :skill_level
          respond_with  :message,
                        text: ObeyBot.vars[:error]
      end
  end

  def show_program(data = nil, *)
      if TelegramWebhookControllerHelper::current_user(from['id']).program.trainings.pluck(:name).include? update["message"]["text"]
          self.show_training

      elsif data.nil?
          save_context  :show_program
          respond_with  :message,
                        text: ObeyBot.user_program_text(from['id']),
                        reply_markup: ObeyBot.user_program_buttons(from['id'])
      else
          save_context  :show_program
          respond_with  :message,
                        text: ObeyBot.vars[:error]
    end
  end

  def show_training(data = nil, *)
      if data == "Назад"
          self.show_program

      elsif data == "Выполнил"
          save_context  :show_training
          respond_with  :message,
                        text: ObeyBot.vars[:training_done],
                        reply_markup: ObeyBot.vars[:remove_keyboard]
          respond_with  :message,
                        text: ObeyBot.vars[:return],
                        reply_markup: ObeyBot.user_training_buttons(from['id'], data)
      elsif data.nil?
          save_context  :show_training
          respond_with  :message,
                        text: ObeyBot.user_training_text(from['id'], update["message"]["text"]),
                        reply_markup: ObeyBot.user_training_buttons(from['id'], data)
      else
          save_context  :show_training
          respond_with  :message,
                        text: ObeyBot.vars[:error]
    end
  end

end
