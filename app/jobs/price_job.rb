class PriceJob
  @queue = :update_price

  def self.perform
    puts 'price job performing'
    Price.request_price
  end

end