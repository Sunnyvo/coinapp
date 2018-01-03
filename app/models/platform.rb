class Platform < ApplicationRecord
 has_many :coins
 has_many :prices, through: :coins

  # def self.request_data(currency)
  #   require 'httparty'
  #   url=`https://api.coinbase.com/v2/prices/#{currency}/spot`
  #   response = HTTParty.get(url)
  #   worth= response.parsed_response['data']['amount']
  # end
end
