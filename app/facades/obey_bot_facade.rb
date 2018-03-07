class ObeyBotFacade

  def self.welcome_text(data)
    "Hello #{responce_appeal(data)}! %2FРаскажи немного о себе. Сколько тебе лет?"
  end

private
  def self.responce_appeal(data)
    if data.key?("first_name") && data.key?("last_name") && data['first_name'].present? && data['last_name'].present?
      data['first_name'] + ' ' + data['last_name']
    elsif data.key?("username")
      data['username']
    else
      'stranger'
    end
  end

end
