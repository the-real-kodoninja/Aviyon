# Import modular components
nav = require './nav.coffee'
portfolio = require './portfolio.coffee'
trading = require './trading.coffee'
marketInsights = require './market_insights.coffee'
virtualSimulator = require './virtual_simulator.coffee'
stakingPools = require './staking_pools.coffee'
socialTrading = require './social_trading.coffee'
companyFeed = require './company_feed.coffee'
kodoverseLore = require './kodoverse_lore.coffee'

# Initialize all components on DOM load
document.addEventListener 'DOMContentLoaded', ->
  nav.init()
  portfolio.init()
  trading.init()
  marketInsights.init()
  virtualSimulator.init()
  stakingPools.init()
  socialTrading.init()
  companyFeed.init()
  kodoverseLore.init()
