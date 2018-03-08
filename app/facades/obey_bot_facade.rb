class ObeyBotFacade

  def self.start(data)
    User.create(UserSaveAdapter.adapt(data))
    ObeyBot.say_welcome(data)
  end

  def self.set_age(words)
    User.update(age: words[0])
    ObeyBot.say_age(words)
  end

end
