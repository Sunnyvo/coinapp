
# class PricesJob < ApplicationJob
#   queue_as :default

#   def perform
#     puts 'test'
#       Price.request_price
#       ActionCable.server.broadcast 'prices',
#       platforms:ActiveSupport::JSON.decode(rerender_platforms())
#   end

#   private
  # def rerender_platforms
  #     @platforms = Platform.all
  #     ApplicationController.render(
  #     template: "platforms/index.json.jbuilder"
  #     )
  # end
# end
# # PricesJob.set(wait: 15.seconds).perform_later