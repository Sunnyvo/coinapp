class ChartJob
  @queue = :update_chart
  def self.perform
    begin
      puts "chart job"
      begin
        # connection = Bunny.new ENV['CLOUDAMQPURL']

        connection = Bunny.new(host: 'localhost')
        connection.start
      rescue Bunny::TCPConnectionFailed => e
        puts "Connection to localhost failed"
      end

      channel = connection.create_channel
      queue = channel.queue('chartqueue', :durable => true, :auto_delete => false)
      queue.subscribe(manual_ack: true ,block: true) do |delivery_info, properties, payload|
        puts "properties:"
        puts properties
        ActionCable.server.broadcast 'prices', data: payload
        msg_cnt = queue.message_count()
        if (msg_cnt == 0)
          channel.acknowledge(delivery_info.delivery_tag, false)
          puts "consumer Got latest message redelivered?: #{delivery_info.redelivered?}, ack-ed"
        else
          puts "error during subscribing ?: #{delivery_info.redelivered?}"
          puts "number messages in queue: #{queue.message_count()}"
        end
      end
    rescue
      connection.close
    end
  end
end