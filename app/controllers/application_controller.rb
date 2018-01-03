class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :request_data_basecoin

  def request_data_basecoin(currency)
    require 'httparty'
    url ='https://api.coinbase.com/v2/prices/' + currency
    url = url + '/spot'
    response = HTTParty.get(url)
    worth= response.parsed_response['data']['amount']
  end

  def request_data_basecoin(currency)
    require 'httparty'
    url ='https://api.coinbase.com/v2/prices/' + currency
    url = url + '/spot'
    response = HTTParty.get(url)
    worth= response.parsed_response['data']['amount']
  end

  def request_data_bittrex(currency)
    require 'httparty'
    url ='https://bittrex.com/api/v1.1/public/getmarketsummary?market=' + currency
    response = HTTParty.get(url)
    worth= response.parsed_response['result'].first['Bid']
  end

  def request_data_poloniex(currency)
    require 'httparty'
    url ='https://poloniex.com/public?command=returnOrderBook&currencyPair=' + currency
    url = url + '&depth=1'
    response = HTTParty.get(url)
    worth = response.parsed_response['bids'].first['0']
  end
end
