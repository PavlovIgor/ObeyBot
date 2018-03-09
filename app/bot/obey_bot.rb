class ObeyBot

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
    "Теперь укажите Ваш пол. м - мужской, ж -женский"
  end

  def self.gender_answer
    "Отлично!"
  end

  def self.skills_question
    "Теперь давай выберем твой уровень."
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
