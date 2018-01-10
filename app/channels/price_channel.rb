class PriceChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'prices'
    while 1 do
      prices = Price.request_price
      prices.each do |price|
        ActionCable.server.broadcast 'prices',
          price: price.worth,
          coin_id: price.coin_id,
          platform_id: price.platform_id
      end
      sleep 15
    end
  end
end