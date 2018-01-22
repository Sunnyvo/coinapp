class PriceChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'prices'
    while 1 do
      Price.request_price
      platforms = Price.data_of_platform_market
      ActionCable.server.broadcast 'prices',
        data:  ApplicationController.render(

          template: "prices/index.json.jbuilder", locals: { platforms: platforms}
        )
      sleep 15
    end

    # while 1 do
    #   prices = Price.request_data
    #   # platforms = Platform.find_by_id(request.params[platforms])
    #   #   ActionCable.server.broadcast 'prices',
    #   #   platforms:ActiveSupport::JSON.decode(
    #   #     ApplicationController.render(

    #   #       template: "platforms/index.json.jbuilder", locals: {platforms: platforms}
    #   #       )
    #   #   )
    #   puts prices
    #   ActionCable.server.broadcast 'prices',
    #   # ActiveSupport::JSON.decode(
    #     prices:  ApplicationController.render(

    #       template: "prices/index.json.jbuilder", locals: {prices: prices}
    #     )
    #   sleep 15
    # end
  end


end