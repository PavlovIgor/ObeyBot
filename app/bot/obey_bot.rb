class ObeyBot

  def self.vars
    {
      menu:                 "Меню",
      settings:             "Настройки",
      program:              "Программа",
      man:                  "мужской",
      woman:                "женский",
      low_skill:            "новичок",
      medium_skill:         "продолжающий",
      high_skill:           "продвинутый",
      done:                 "Выполнил",
      back:                 "Назад",
      show_program:         "/show_program",
      error:                "Неверный формат. Повторите попытку.",
      age_question:         "Сколько Вам лет?",
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

  def self.user_program_text(current_user)
    "\r\n" + current_user.program.name
  end

  def self.user_training_text(current_user, data)
    completed = Completed.where(  user: current_user,
                                  training: current_user.program.trainings.find_by_name(training_name)
    data +
    "\r\n\r\nОписание\r\n\r\n" +
    current_user.program.trainings.find_by_name(data).description +
    completed ? "\r\n\r\nВыполенено " + completed.created_at : ""
  end



  def self.gender_keyboard
    { keyboard: [[ self.vars[:man], self.vars[:woman] ]] }
  end

  def self.skills_keyboard
    { keyboard: Program.all.collect { |x| [x.name] } }
  end

  def self.menu_keyboard
    { keyboard: [ [self.vars[:settings]], [self.vars[:program]] ] }
  end

  def self.user_program_buttons(current_user)
    { keyboard: current_user.program.trainings.order(:queue).collect { |x| [x.name] } }
  end

  def self.user_training_buttons(current_user, training_name)
    if Completed.where( user: current_user,
                        training: current_user.program.trainings.find_by_name(training_name)
    ).present?
      { keyboard: [ [self.vars[:back]] ] }
    else
      { keyboard: [ [self.vars[:done]], [self.vars[:back]] ] }
    end
  end

private

  def self.responce_appeal(data)
      if data['first_name'].present? && data['last_name'].present?
          data['first_name'] + ' ' + data['last_name']
      elsif data['username'].present?
          data['username']
      else
          'stranger'
      end
  end

end
