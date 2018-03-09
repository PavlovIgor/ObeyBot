class ObeyBotFacade

  def self.start(data)
    user = User.find_by_from_key(data['id'])
    if not user
      User.create!(UserSaveAdapter.adapt(data))
    end
    ObeyBot.say_welcome(data)
  end

  def self.age_answer(value, from_key)
    User.find_by_from_key(from_key).update(age: value)
    ObeyBot.age_answer
  end

  def self.gender_answer(value, from_key)
    User.find_by_from_key(from_key).update(gender: value)
    ObeyBot.gender_answer
  end

  def self.skill_level_answer(value, from_key)
    user = User.find_by_from_key(from_key)
    user.skill_level = value
    # TODO: bullshit solution, it's temporary
    if value == "новичок"
      user.program = Program.first
    end
    user.save
    ObeyBot.skill_level_answer
  end

end
