# open connections
# wait and listen to message.
class RabbitmqJob 
  @queue = :queue_chart
  def self.perform

    puts 'Hello rabbit job'
  # queue chart with rabbit MQ
    platforms = Price.data_of_platform_market
    data = ApplicationController.render(
      template: 'prices/index.json.jbuilder', locals: { platforms: platforms}
    )
    # connection = Bunny.new ENV['CLOUDAMQPURL']
    connection = Bunny.new(host: 'localhost')
    connection.start
    channel = connection.create_channel
    queue = channel.queue('chartqueue', durable: true)
    exchange = channel.direct('chartexchange', :durable => true, :auto_delete => false)

    queue.bind(exchange, :routing_key => 'update_chart')
    puts data
    exchange.publish(data,
      :timestamp      => Time.now.to_i,
      :routing_key    => "update_chart"
    )
    sleep 1.0
    connection.close
  end
end