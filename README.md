# Project 1 - *Coin application*

**Coin application** is a market platforms app using the [coins Database API]
from
- [X] Coinbase: https://developers.coinbase.com/api/v2
- [X] Bittrex: https://bittrex.com/home/api
- [] Poloniex: https://poloniex.com/support/api/



## User Stories
## How to start:
**step 0**

- install: postgres, rails, ruby, elasticsearch, redis, rabbitMQ.

**step 1**

- git clone https://github.com/Sunnyvo/frontendcoinapp for frontend.
- git clone https://github.com/Sunnyvo/coinapp for backend.

**step 2**

- Systemd
  + cd path/to/systemd/system (cmd: cd lib/systemd/system)
  + create a updatechart.service (cmd: vim updatechart.service)

[Unit]
Description=Resque queuechartjobs
After=redis.service

[Service]
Type=simple
WorkingDirectory=/home/testing/Documents/testrails/coinapp
User=testing
ExecStart=/home/testing/.rbenv/shims/bundle exec rake resque:work QUEUE=queue_chart
Restart=always
[Install]
WantedBy=multi-user.target






- Backend
  + bundle (update gem)
  + rails db:drop db:create db:migrate db:seed
  + config .env file with CLOUDAMQPURL=""

  + **Start these servers and workers below**
  + web: rails server -p 3000
  + redis: redis-server
  + worker: QUEUE=update_price rake resque:work
  + worker: QUEUE=queue_chart rake resque:work
  + job_fetch_price: rake resque:scheduler



- Frontend
  + npm install ( redependencies)
  + Yarn start or npm start for Frontend

**step 3**

- Choose the market platform that we wanna see the price.
- Zoom in or zoom out for the chart.


## Video Walkthrough