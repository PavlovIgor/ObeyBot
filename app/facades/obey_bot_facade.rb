class ObeyBotFacade

  def self.start(data)
    User.create(UserSaveAdapter.adapt(data))
    ObeyBot.say_welcome(data)
  end

end
