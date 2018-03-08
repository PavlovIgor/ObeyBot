class ObeyBotFacade

  def self.start(data)
    User.create(UserSaveAdapter.adapt(data))
    ObeyBot.say_welcome(data)
  end

  def self.age_answer(words)
    User.update(age: words[0])
    ObeyBot.age_answer
  end

  def self.gender_answer(value)
    User.update(gender: value)
    ObeyBot.gender_answer
  end

end
