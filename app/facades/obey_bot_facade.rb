class ObeyBotFacade

  def self.welcome_text(data)
    "Привет #{responce_appeal(data)}!\r\nРаскажи немного о себе. Сколько тебе лет?"
  end


private
  def self.responce_appeal(data)
    if data.key?("first_name") && data.key?("last_name") && data['first_name'].present? && data['last_name'].present?
      data['first_name'] + ' ' + data['last_name']
    elsif data.key?("username") && data['username'].present?
      data['username']
    else
      'stranger'
    end
  end

end
