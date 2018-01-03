class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :request_data_basecoin

  def request_data(currency)
    require 'httparty'
    url=`https://api.coinbase.com/v2/prices/#{currency}/spot`
    response = HTTParty.get(url)
    worth= response.parsed_response['data']['amount']
  end
end
