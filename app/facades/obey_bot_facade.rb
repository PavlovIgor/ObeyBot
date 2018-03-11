class ObeyBotFacade

  def self.start(data, current_user)
    User.create!(UserSaveAdapter.adapt(data)) if not current_user
  end

  def self.set_age(value, current_user)
    current_user.update(age: value)
  end

  def self.set_gender(value, current_user)
    current_user.update(gender: value)
  end

  def self.set_skill_level(value, current_user)
    current_user.skill_level = value
    current_user.program = Program.find_by_name(value)
    current_user.save
  end

  def self.training_done(current_user, training_name)
    Completed.create( user:     current_user,
                      training: current_user.program.trainings.find_by_name(training_name))
  end

end
