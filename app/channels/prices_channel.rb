class PricesChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'prices'
  end
end