# Bot periodista
require 'cinch'
require 'broadcast'

Broadcast.setup do |config|
  config.jabber { |jabber|
    jabber.username = ""
    jabber.password = ""
    jabber.recipients = ""
  }
end

reed = Cinch::Bot.new do

  configure do |c|
    c.nick = "reed"
    c.server = "irc.hackcoop.com.ar"
    c.port = 6697
    c.ssl.use = true
    c.channels = [ "#test" ]

    @taking_notes = false
  end

  on :message, "+j" do |m|
    @taking_notes = true
    m.reply "tomando nota :)"
  end

  on :message, "-j" do |m|
    @taking_notes = true
    m.reply "ok"
  end

  on :message do |m|
    Broadcast::Message::Simple.new(:body => m.message).publish(:jabber) if @taking_notes
  end

end

reed.start
