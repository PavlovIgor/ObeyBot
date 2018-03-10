class ObeyBot
  include TelegramWebhookControllerHelper

  def self.vars
    {
      man:                  "мужской",
      woman:                "женский",
      low_skill:            "новичок",
      medium_skill:         "продолжающий",
      high_skill:           "продвинутый",
      show_program:         "/show_program",
      error:                "Неверный формат. Повторите попытку.",
      age_question:         "Сколько тебе лет?",
      age_answer:           "Отлично!",
      gender_question:      "Теперь укажите Ваш пол.",
      gender_answer:        "Отлично!",
      skill_level_question: "Теперь выберем Ваш уровень.",
      skill_level_answer:   "Отлично!",
      user_program:         "Ваша программа!",
      training_done:        "Отлично!",
      return:               "Можете вернуться к списку тренировок",
      remove_keyboard:      {remove_keyboard: true},
    }
  end

  def self.say_welcome(data)
    "Привет #{responce_appeal(data)}!\r\nРаскажите немного о себе."
  end

  def self.user_program_text(from_key)
    user = TelegramWebhookControllerHelper::current_user(from_key)
    "\r\n" + user.program.name
  end

  def self.user_training_text(from_key, data)
    user = TelegramWebhookControllerHelper::current_user(from_key)
    data + "\r\n\r\nОписание\r\n\r\n" + user.program.trainings.find_by_name(data).description
  end


  def self.gender_keyboard
    { keyboard: [[ self.vars[:man], self.vars[:woman] ]] }
  end

  def self.skills_keyboard
    { keyboard: Program.all.collect { |x| [x.name] } }
  end

  def self.user_menu
    { keyboard: [[self.vars[:user_program]]] }
  end

  def self.user_program_buttons(from_key)
    user = TelegramWebhookControllerHelper::current_user(from_key)
    { keyboard: user.program.trainings.collect { |x| [x.name] } }
  end

  def self.user_training_buttons(from_key, data)
    user = TelegramWebhookControllerHelper::current_user(from_key)
    TrainingButtonAdapter.adapt(user.program.trainings.find_by_name(data))
  end

private

  def self.responce_appeal(data)
      if data['first_name'].present? &&
      data['last_name'].present?
          data['first_name'] + ' ' + data['last_name']

      elsif data.key?("username") &&
      data['username'].present?
          data['username']

      else
          'stranger'
      end
  end

end
