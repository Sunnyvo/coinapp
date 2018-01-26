class ChartJob
  @queue = :update_chart
  def self.perform
      connection = Bunny.new ENV['CLOUDAMQPURL']
      connection.start
      channel = connection.create_channel
      queue = channel.queue('chartqueue', durable: true)

      queue.subscribe(block: true) do |delivery_info, properties, payload|
        ActionCable.server.broadcast 'prices', data: payload
        end
  end


end