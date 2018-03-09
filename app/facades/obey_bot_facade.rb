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

  def self.skill_level_answer(value)
    User.update(skill_level: value)
    ObeyBot.skill_level_answer
  end

  def self.user_program(from_key)
    user = User.find_by_from_key(from_key)
    "\r\n" + user.program.name + "\r\n" + TrainingListAdapter.adapt(user.program.trainings.all)
  end

end
