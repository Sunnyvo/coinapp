require 'sneakers'
require 'json'
require "action_cable"
# require ''
# require_relative 'config/application'
class Chartupdate
  include Sneakers::Worker
  from_queue 'chartqueue'

  def work(msg)
    puts 'hi1111111111111111111111111111111111111'
    payload = JSON.parse(msg)
    puts 'hi2222222222222222222222222222222222222'
    binding.pry
    ActionCable.server.broadcast 'prices', data: payload
    puts '3'
    ack!
  end
end