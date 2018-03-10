class ObeyBotFacade

  def self.start(data)

    user = TelegramWebhookControllerHelper::current_user(data['id'])
    User.create!(UserSaveAdapter.adapt(data)) if not user

    ObeyBot.say_welcome(data)
  end

  def self.age_answer(value, from_key)
    TelegramWebhookControllerHelper::current_user(from_key).update(age: value)

    ObeyBot.age_answer
  end

  def self.gender_answer(value, from_key)
    TelegramWebhookControllerHelper::current_user(from_key).update(gender: value)

    ObeyBot.gender_answer
  end

  def self.skill_level_answer(value, from_key)
    user = TelegramWebhookControllerHelper::current_user(from_key)
    user.skill_level = value
    # TODO: bullshit solution, it's temporary
    user.program = Program.first if value == "новичок"
    user.save

    ObeyBot.skill_level_answer
  end

end
