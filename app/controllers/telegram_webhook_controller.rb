class TelegramWebhookController < Telegram::Bot::UpdatesController

  def message(message)
    respond_with :message, text: message['text']
  end

  def start(*)
    respond_with :message, text: "Hello #{responce_appeal(from)}! Let me know little more about you." if from
  end

private
  def responce_appeal(from)
    if from.key?("first_name") and from.key?("last_name")
      from['first_name'] + ' ' + from['last_name']
    elsif from.key?("username")
      from['username']
    end
  end

end
