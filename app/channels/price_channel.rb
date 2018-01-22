class PriceChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'prices'
    while 1 do
      # query = params[:date].presence || "*"
      prices = Price.return_all_data
      platforms = Platform.find_by_id(request.params[platforms])
      #   ActionCable.server.broadcast 'prices',
      #   platforms:ActiveSupport::JSON.decode(
      #     ApplicationController.render(

      #       template: "platforms/index.json.jbuilder", locals: {platforms: platforms}
      #       )
      #   )
      puts prices
      ActionCable.server.broadcast 'prices',
      # ActiveSupport::JSON.decode(
        prices:  ApplicationController.render(

          template: "prices/index.json.jbuilder", locals: {prices: prices}
        )
      # )
      sleep 15
    end
  end


end