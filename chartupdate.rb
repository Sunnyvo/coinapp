require 'sneakers'
require_relative 'config/application'
class Chartupdate

  include Sneakers::Worker
  from_queue 'chartqueue'
  def work(msg)
      ActionCable.server.broadcast 'prices', data: msg
    ack!
  end
end