class PriceJob
  @queue = :update_price

  def self.perform
    puts 'price job performing'
    Price.request_price
    # ActionCable.server.broadcast 'prices',
    #   platforms:ActiveSupport::JSON.decode(rerender_platforms())

  end

  private
  def rerender_platforms
      @platforms = Platform.all
      ApplicationController.render(
      template: "platforms/index.json.jbuilder"
      )
  end
end