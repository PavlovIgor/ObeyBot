class ObeyBotFacade

  def self.new_user(data)
      user = TelegramWebhookControllerHelper::current_user(data['id'])
      User.create!(UserSaveAdapter.adapt(data)) if not user
  end

  def self.set_age(value, from_key)
      TelegramWebhookControllerHelper::current_user(from_key).update(age: value)
  end

  def self.set_gender(value, from_key)
      TelegramWebhookControllerHelper::current_user(from_key).update(gender: value)
  end

  def self.set_skill_level(value, from_key)
      user = TelegramWebhookControllerHelper::current_user(from_key)
      user.skill_level = value
      user.program = Program.find_by_name(value)
      user.save
  end

end
