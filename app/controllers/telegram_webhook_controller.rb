class TelegramWebhookController < Telegram::Bot::UpdatesController
  include Telegram::Bot::UpdatesController::MessageContext
  context_to_action!
  use_session!

  before_action :check_settings,
                only: [:menu, :program, :show_program, :show_training]

  def start(*)
      ObeyBotFacade.start(from, current_user)
      respond_with  :message,
                    text: ObeyBot.say_welcome(from)
      self.age
  end

  def settings
    self.age
  end

  def program
    self.show_program
  end

  def age(age = nil, *)
      if (Integer(age) rescue false)
          ObeyBotFacade.set_age(age, current_user)
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
          ObeyBotFacade.set_gender(data, current_user)
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
      if Program.all.pluck(:name).include? update["message"]["text"]
          ObeyBotFacade.set_skill_level(update["message"]["text"], current_user)
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

  def menu(data = nil, *)
    return if @ready == false
    if data == ObeyBot.vars[:settings]
      self.settings
    elsif data == ObeyBot.vars[:program]
      self.program
    elsif data.nil?
      save_context  :menu
      respond_with  :message,
                    text: ObeyBot.vars[:menu],
                    reply_markup: ObeyBot.menu_keyboard
    else
      save_context  :menu
      respond_with  :message,
                    text: ObeyBot.vars[:error]
    end
  end

  def show_program(data = nil, *)
    return if @ready == false
      if current_user.program.trainings.pluck(:name).include? update["message"]["text"]
        session[:current_training_name] = update["message"]["text"]
        self.show_training

      elsif data.nil?
          save_context  :show_program
          respond_with  :message,
                        text: ObeyBot.user_program_text(current_user),
                        reply_markup: ObeyBot.user_program_buttons(current_user)
      else
          save_context  :show_program
          respond_with  :message,
                        text: ObeyBot.vars[:error]
    end
  end

  def show_training(data = nil, *)
    return if @ready == false
      if data == ObeyBot.vars[:back]
          self.show_program

      elsif data == ObeyBot.vars[:done]
          ObeyBotFacade.training_done(current_user, session[:current_training_name])
          save_context  :show_training
          respond_with  :message,
                        text: ObeyBot.vars[:training_done],
                        reply_markup: ObeyBot.vars[:remove_keyboard]
          respond_with  :message,
                        text: ObeyBot.vars[:return],
                        reply_markup: ObeyBot.user_training_buttons(current_user, session[:current_training_name])
      elsif data.nil?
          save_context  :show_training
          respond_with  :message,
                        text: ObeyBot.user_training_text(current_user, update["message"]["text"]),
                        reply_markup: ObeyBot.user_training_buttons(current_user, session[:current_training_name])
      else
          save_context  :show_training
          respond_with  :message,
                        text: ObeyBot.vars[:error]
    end
  end

  def current_user
    session[:current_user_id] ||= from['id']
    User.find_by_from_key( session[:current_user_id] )
  end

private
  def check_settings
    if current_user.age.nil?
      self.age
      @ready = false
    elsif current_user.gender.nil?
      self.gender
      @ready = false
    elsif current_user.program.nil?
      self.skill_level
      @ready = false
    end
  end


end
