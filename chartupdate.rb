require 'sneakers'
require 'json'
require 'sneakers'
require 'action_cable'
# require_relative 'config/application'
class Chartupdate

  include Sneakers::Worker
  from_queue 'chartqueue'
  def work(msg)
    payload = JSON.parse(msg)
    puts  ActionCable
    ActionCable.server.broadcast 'prices', data: payload
    ack!
  end
end