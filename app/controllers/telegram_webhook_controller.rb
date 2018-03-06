class TelegramWebhookController < Telegram::Bot::UpdatesController

  def message(message)
    respond_with :message, text: message['text']
  end

  def start(*)
    respond_with :message, text: "Hello #{responce_appeal(from)}! Let me know little more about you." if from
  end

  # Be sure to use splat args and default values
  # to not get errors when someone passed
  # more or less arguments in the message.
  def help(cmd = nil, *)
    message =
      if cmd
        help_for_cmd?(cmd) ? t(".cmd.#{cmd}") : t('.no_help')
      else
        t('.help')
      end
    reply_with text: message
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
