class ApplicationController < ActionController::Base
  # protect_from_forgery with: :exception
  # include ActionController::MimeResponds
  include ActionController::ImplicitRender
  helper_method :request_data_basecoin
  helper_method :current_user
  helper_method :log_in
  helper_method :log_out

  def request_data_basecoin(currency)
    require 'httparty'
    url ='https://api.coinbase.com/v2/prices/' + currency
    url = url + '/spot'
    response = HTTParty.get(url)
        worth= response.parsed_response['data']['amount']
    return worth
  end

  def request_data_bittrex(currency)
    require 'httparty'
    url ='https://bittrex.com/api/v1.1/public/getmarketsummary?market=' + currency
    response = HTTParty.get(url)
    worth= response.parsed_response['result'].first['Bid']
    return worth
  end

  def request_data_poloniex(currency)
    require 'httparty'
    url ='https://poloniex.com/public?command=returnOrderBook&currencyPair=' + currency
    url = url + '&depth=1'
    response = HTTParty.get(url)
    worth = response.parsed_response['bids'].first['0']
    return worth
  end




  private
  def current_user
    return @current_user if @current_user

    @current_user = User.find_by(id: session[:user_id])
  end
  def log_in(user)
    session[:user_id] = user.id
    puts session[:user_id]
  end

  def log_out
    session[:user_id] = nil
  end
end
