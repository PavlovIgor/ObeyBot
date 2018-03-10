class ObeyBotFacade

  def self.start(data)
      user = TelegramWebhookControllerHelper::current_user(data['id'])
      User.create!(UserSaveAdapter.adapt(data)) if not user
  end

  def self.age_answer(value, from_key)
      TelegramWebhookControllerHelper::current_user(from_key).update(age: value)
  end

  def self.gender_answer(value, from_key)
      TelegramWebhookControllerHelper::current_user(from_key).update(gender: value)
  end

  def self.skill_level_answer(value, from_key)
      user = TelegramWebhookControllerHelper::current_user(from_key)
      user.skill_level = value
      # TODO: bullshit solution, it's temporary
      user.program = Program.first if value == "новичок"
      user.save
  end

end
