# Bot periodista
require 'cinch'
require 'broadcast'
require './config'
require './lib/invite.rb'

Broadcast.setup do |config|
  config.jabber { |jabber|
    jabber.username = JABBER_ACCOUNT
    jabber.password = JABBER_PASSWORD
    jabber.recipients = JABBER_RECIPIENTS
  }

  config.twitter { |twitter|
    twitter.consumer_key    = TWITTER_CONSUMER_KEY
    twitter.consumer_secret = TWITTER_CONSUMER_SECRET
    twitter.access_token    = TWITTER_ACCESS_TOKEN
    twitter.access_secret   = TWITTER_TOKEN_SECRET
  }

# config.email { |email|
#   email.recipients = JABBER_RECIPIENTS
#   email.delivery_method = :sendmail
# }

# La joda de esto es que se conecta y se desconecta
# config.irc { |irc|
#   irc.username = 'reed___'
#   irc.server = 'irc.freenode.net'
#   irc.port = '6667'
#   irc.channel = 'endefensadelsl'
# }
end

module Cinch
  class Message
    include Broadcast::Publishable

# TODO cargar estos dinámicamente
    medium :jabber
    medium :twitter
#    medium :email
#    medium :irc

    def body
      self.message
    end

    def subject
      self.message
    end

  end
end

reed = Cinch::Bot.new do

  configure do |c|
    c.nick = NICK
    c.server = SERVER
    c.port = PORT
    c.ssl.use = SSL
    c.channels = CHANNELS
    c.plugins.plugins = [ AcceptInvite ]

    @taking_notes = false
  end

  on :message, "+j" do |m|
    @taking_notes = true
    m.reply "tomando nota :)"
  end

  on :message, "-j" do |m|
    @taking_notes = false
    m.reply "ok"
  end

  # Dejar de tomar notas si entra alguien al canal
  on :join do |m|
    m.reply "shhh, viene alguien!" if @taking_notes
    @taking_notes = false
  end

# Publicar todo si estamos tomando notas
  on :message, /^[^\-+][^j]/ do |m|
    m.publish if @taking_notes
  end

end

reed.start
