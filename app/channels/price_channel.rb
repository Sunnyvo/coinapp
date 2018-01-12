class PriceChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'prices'
    while 1 do
      prices = Price.request_price
      platforms = Platform.all
        ActionCable.server.broadcast 'prices',
        platforms:ActiveSupport::JSON.decode(
          ApplicationController.render(

            template: "platforms/index.json.jbuilder", locals: {platforms: platforms}
            )
        )
      sleep 15
    end
  end


end