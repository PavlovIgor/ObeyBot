class ObeyBot

  def self.say_welcome(data)
    "Привет #{responce_appeal(data)}!\r\nРаскажи немного о себе. Сколько тебе лет?"
  end

  def self.say_age(words)
    "Отлично! Теперь укажите Ваш пол."
  end

  def self.say_gender
    "Отлично! Теперь давай выберем твой уровень."
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
