require 'twilio-ruby'
require 'phony'

def send_invite_message(phone_number) 
  client = Twilio::REST::Client.new ENV['TW_SSID'], ENV['TW_AUTH']
  client.account.messages.create({
    from: '+12044006394',
    to:   "+1#{get_twilio_number(phone_number)}",
    body: 'Coffee Roulette'
  })
end

def send_link_message(id) 
  client = Twilio::REST::Client.new ENV['TW_SSID'], ENV['TW_AUTH']
  client.account.messages.create({
    from: '+12044006394',
    to:   "+1#{get_twilio_number(phone_number)}",
    body: "Coffee order link: https://coffee-roulette-dev.herokuapp.com/#{id}"
  })
end
