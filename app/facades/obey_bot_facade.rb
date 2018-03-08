class ObeyBotFacade

  def self.start(data)
    User.create(UserSaveAdapter.adapt(data))
    ObeyBot.say_welcome(data)
  end

  def self.set_age(words)
    User.update(age: words[0])
    ObeyBot.say_age(words)
  end

  def self.set_gender(value)
    User.update(gender: value)
    ObeyBot.say_gender
  end

end
