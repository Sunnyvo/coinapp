# Project 1 - *Coin application*

**Coin application** is a market platforms app using the [coins Database API]
from
- [X] Coinbase: https://developers.coinbase.com/api/v2
- [X] Bittrex: https://bittrex.com/home/api
- [] Poloniex: https://poloniex.com/support/api/



## User Stories
## How to start:
**step 1**

- git clone https://github.com/Sunnyvo/frontendcoinapp for frontend.
- git clone https://github.com/Sunnyvo/coinapp for backend.

**step 2**

- Backend
  + bundle (update gem)
  + rails db:drop db:create db:migrate db:seed
  + config .env file with CLOUDAMQPURL=""

- Start these servers and workers below
  + web: rails server -p 3000
  + redis: redis-server
  + worker: QUEUE=update_price rake resque:work
  + worker: QUEUE=update_chart rake resque:work
  + worker: QUEUE=queue_chart rake resque:work
  + job_fetch_price: rake resque:scheduler

- Frontend
  + npm install ( redependencies)
  + Yarn start or npm start for Frontend

**step 3**

- Choose the market platform that we wanna see the price.
- Zoom in or zoom out for the chart.


## Video Walkthrough