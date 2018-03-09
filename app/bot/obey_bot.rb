class ObeyBot

  def self.vars
    {
      man_gender_var: "м",
      woman_gender_var: "ж",
      low_skill_level_var: "н",
      medium_skill_level_var: "с",
      high_skill_level_var: "в"
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
    "Теперь укажите Ваш пол.\r\n #{self.vars[:man_gender_var]} - мужской, #{self.vars[:woman_gender_var]} -женский"
  end

  def self.gender_answer
    "Отлично!"
  end

  def self.skill_level_question
    "Теперь давай выберем твой уровень.\r\n #{self.vars[:low_skill_level_var]} - начинающий, #{self.vars[:medium_skill_level_var]} - средний, #{self.vars[:high_skill_level_var]} - высокий"
  end

  def self.skill_level_answer
    "Отлично!"
  end

  def self.user_program
    "Вот твоя программа!"
  end

  def self.gender_keyboard
    {
      inline_keyboard: [
        [
          {text: 'Муж', callback_data: 'Муж'},
          {text: 'Жен', callback_data: 'Жен'},
        ]
      ],
    }
  end

  def self.skills_keyboard
    {
      inline_keyboard: [
        [
          {text: 'Начинающий', callback_data: 'low'},
          {text: 'Средний', callback_data: 'mid'},
          {text: 'Профи', callback_data: 'high'},
        ]
      ],
    }
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
