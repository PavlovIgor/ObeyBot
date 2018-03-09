class ObeyBot

  def self.vars
    {
      man_gender_var: "мужской",
      woman_gender_var: "женский",
      low_skill_level_var: "новичок",
      medium_skill_level_var: "продолжающий",
      high_skill_level_var: "продвинутый",
      show_user_program: "/show_program"
    }
  end

  def self.say_error
    "Неверный формат. Повторите попытку."
  end

  def self.say_welcome(data)
    "Привет #{responce_appeal(data)}!\r\nРаскажи немного о себе."
  end

  def self.age_question
    "Сколько тебе лет?"
  end

  def self.age_answer
    "Отлично!"
  end

  def self.gender_question
    "Теперь укажите Ваш пол."
  end

  def self.gender_answer
    "Отлично!"
  end

  def self.skill_level_question
    "Теперь давай выберем твой уровень."
  end

  def self.skill_level_answer
    "Отлично!"
  end

  def self.user_program
    "Вот твоя программа!"
  end

  def self.remove_keyboard
    {
      remove_keyboard: true
    }
  end

  def self.gender_keyboard
    {
      keyboard: [[
        self.vars[:man_gender_var],
        self.vars[:woman_gender_var]
        ]],
      resize_keyboard: true,
    }
  end

  def self.skills_keyboard
    {
      keyboard: [
        [self.vars[:low_skill_level_var]],
        [self.vars[:medium_skill_level_var]],
        [self.vars[:high_skill_level_var]]
      ],
      resize_keyboard: true,
    }
  end

  def self.user_menu
    {
      keyboard: [
        [self.vars[:show_user_program]],
      ],
      resize_keyboard: true,
    }
  end

  def self.user_program(from_key)
    user = User.find_by_from_key(from_key)
    "\r\n" + user.program.name + "\r\n" + TrainingListAdapter.adapt(user.program.trainings.all.order(:queue))
  end


private
  def self.responce_appeal(data)
    if data.key?("first_name") && data.key?("last_name") && data['first_name'].present? && data['last_name'].present?
      data['first_name'] + ' ' + data['last_name']
    elsif data.key?("username") && data['username'].present?
      data['username']
    else
      'stranger'
    end
  end

end
