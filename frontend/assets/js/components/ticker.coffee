# assets/js/components/ticker.coffee

# Import Chart.js and candlestick chart
Chart = require 'chart.js'
{ CandlestickController, CandlestickElement } = require 'chartjs-chart-financial'

# Register the candlestick chart type
Chart.register CandlestickController, CandlestickElement

# Constants
UPDATE_INTERVAL = 45000  # 45 seconds
SYMBOLS = [
  { symbol: 'AAPL', type: 'stock', basePrice: 175.32, change: 2.3, volume: '45M', rsi: 65, specific: 'Market Cap: $2.8T' }
  { symbol: 'MSFT', type: 'stock', basePrice: 420.45, change: -0.5, volume: '30M', rsi: 70, specific: 'Market Cap: $3.1T' }
  { symbol: 'GOOGL', type: 'stock', basePrice: 150.25, change: 1.8, volume: '25M', rsi: 62, specific: 'Market Cap: $1.9T' }
  { symbol: 'AMZN', type: 'stock', basePrice: 185.67, change: -1.2, volume: '40M', rsi: 58, specific: 'Market Cap: $1.9T' }
  { symbol: 'TSLA', type: 'stock', basePrice: 265.89, change: 3.5, volume: '50M', rsi: 75, specific: 'Market Cap: $850B' }
  { symbol: 'NVDA', type: 'stock', basePrice: 870.12, change: 2.1, volume: '35M', rsi: 80, specific: 'Market Cap: $2.2T' }
  { symbol: 'META', type: 'stock', basePrice: 495.34, change: -0.9, volume: '20M', rsi: 60, specific: 'Market Cap: $1.3T' }
  { symbol: 'JPM', type: 'stock', basePrice: 195.78, change: 0.7, volume: '15M', rsi: 55, specific: 'Market Cap: $570B' }
  { symbol: 'V', type: 'stock', basePrice: 275.56, change: 1.3, volume: '10M', rsi: 63, specific: 'Market Cap: $560B' }
  { symbol: 'WMT', type: 'stock', basePrice: 60.23, change: -0.3, volume: '25M', rsi: 52, specific: 'Market Cap: $485B' }
  { symbol: 'DIS', type: 'stock', basePrice: 115.89, change: 0.9, volume: '18M', rsi: 57, specific: 'Market Cap: $210B' }
  { symbol: 'NFLX', type: 'stock', basePrice: 625.45, change: -1.5, volume: '12M', rsi: 64, specific: 'Market Cap: $270B' }
  { symbol: 'AMD', type: 'stock', basePrice: 165.78, change: 2.7, volume: '30M', rsi: 72, specific: 'Market Cap: $210B' }
  { symbol: 'INTC', type: 'stock', basePrice: 40.12, change: -0.8, volume: '22M', rsi: 48, specific: 'Market Cap: $170B' }
  { symbol: 'CSCO', type: 'stock', basePrice: 50.34, change: 0.4, volume: '15M', rsi: 53, specific: 'Market Cap: $205B' }
  { symbol: 'BTC', type: 'crypto', basePrice: 62450.00, change: 3.1, volume: '$35B', dominance: 54, specific: 'Market Cap: $1.2T' }
  { symbol: 'ETH', type: 'crypto', basePrice: 3250.75, change: -0.6, volume: '$15B', dominance: 18, specific: 'Market Cap: $390B' }
  { symbol: 'BNB', type: 'crypto', basePrice: 580.23, change: 1.9, volume: '$2B', dominance: 4, specific: 'Market Cap: $87B' }
  { symbol: 'ADA', type: 'crypto', basePrice: 0.58, change: -2.1, volume: '$500M', dominance: 1, specific: 'Market Cap: $20B' }
  { symbol: 'XRP', type: 'crypto', basePrice: 0.62, change: 0.8, volume: '$1B', dominance: 1.5, specific: 'Market Cap: $34B' }
  { symbol: 'SOL', type: 'crypto', basePrice: 175.45, change: 2.3, volume: '$3B', dominance: 2, specific: 'Market Cap: $78B' }
  { symbol: 'DOGE', type: 'crypto', basePrice: 0.18, change: -1.7, volume: '$800M', dominance: 0.5, specific: 'Market Cap: $25B' }
  { symbol: 'SPY', type: 'index', basePrice: 510.25, change: -1.2, volume: '80M', bollinger: 1.2, specific: 'Assets: $400B' }
  { symbol: 'DIA', type: 'index', basePrice: 385.67, change: 0.5, volume: '40M', bollinger: 1.0, specific: 'Assets: $350B' }
  { symbol: 'QQQ', type: 'index', basePrice: 435.89, change: -0.9, volume: '50M', bollinger: 1.5, specific: 'Assets: $200B' }
  { symbol: 'IWM', type: 'index', basePrice: 205.34, change: 1.1, volume: '30M', bollinger: 1.3, specific: 'Assets: $60B' }
  { symbol: 'GOLD', type: 'commodity', basePrice: 2350.60, change: 0.9, volume: '120K', openInterest: '450K', specific: 'Open Interest: 450K' }
  { symbol: 'OIL', type: 'commodity', basePrice: 85.23, change: -0.4, volume: '200K', openInterest: '600K', specific: 'Open Interest: 600K' }
  { symbol: 'SILVER', type: 'commodity', basePrice: 27.45, change: 1.2, volume: '150K', openInterest: '300K', specific: 'Open Interest: 300K' }
  { symbol: 'CORN', type: 'commodity', basePrice: 450.78, change: -0.7, volume: '80K', openInterest: '200K', specific: 'Open Interest: 200K' }
]

# Helper to format numbers
formatNumber = (num) ->
  if num >= 1e9
    "#{Math.round(num / 1e8) / 10}B"
  else if num >= 1e6
    "#{Math.round(num / 1e5) / 10}M"
  else if num >= 1e3
    "#{Math.round(num / 100) / 10}K"
  else
    num.toFixed(2)

# Candlestick Chart Helper
createCandlestickChart = (ctx, data, color) ->
  console.log "Creating candlestick chart for #{ctx.id}"
  new Chart ctx,
    type: 'candlestick'
    data:
      datasets: [{
        label: ''
        data: data
        borderColor: color
        backgroundColor: color
      }]
    options:
      responsive: true
      scales:
        x: { display: false }
        y: { display: false }
      plugins:
        legend: { display: false }
        tooltip: { enabled: false }

# Line Chart Helper
createLineChart = (ctx, data, color) ->
  console.log "Creating line chart for #{ctx.id}"
  new Chart ctx,
    type: 'line'
    data:
      labels: Array(data.length).fill('')
      datasets: [{
        data: data
        borderColor: color
        backgroundColor: 'transparent'
        borderWidth: 1
        pointRadius: 0
      }]
    options:
      responsive: true
      scales:
        x: { display: false }
        y: { display: false }
      plugins:
        legend: { display: false }
        tooltip: { enabled: false }

# Detailed Chart Helper
createDetailedChart = (ctx, data, color) ->
  console.log "Creating detailed chart for #{ctx.id}"
  new Chart ctx,
    type: 'line'
    data:
      labels: Array(data.length).fill('').map((_, i) -> "-#{data.length - 1 - i}m")
      datasets: [{
        label: 'Price'
        data: data
        borderColor: color
        backgroundColor: color + '33'
        fill: true
        tension: 0.4
      }]
    options:
      responsive: true
      scales:
        y: { beginAtZero: false }
        x: { display: false }
      plugins:
        legend: { labels: { color: '#d1d5db' } }

# Volume Chart Helper
createVolumeChart = (ctx, data) ->
  console.log "Creating volume chart for #{ctx.id}"
  new Chart ctx,
    type: 'bar'
    data:
      labels: Array(data.length).fill('').map((_, i) -> "-#{data.length - 1 - i}m")
      datasets: [{
        label: 'Volume'
        data: data
        backgroundColor: '#8b5cf6'
      }]
    options:
      responsive: true
      scales:
        y: { beginAtZero: true }
        x: { display: false }

# Simulate Price Update
updatePrice = (symbolData) ->
  console.log "Updating price for #{symbolData.symbol}"
  change = (Math.random() * 4 - 2).toFixed(2)
  priceChange = symbolData.basePrice * (change / 100)
  newPrice = symbolData.basePrice + priceChange
  symbolData.basePrice = newPrice
  symbolData.change = parseFloat(change)

  priceElement = document.querySelector("#price-#{symbolData.symbol.toLowerCase()}")
  changeElement = document.querySelector("#change-#{symbolData.symbol.toLowerCase()}")
  arrowElement = document.querySelector("#arrow-#{symbolData.symbol.toLowerCase()}")

  if priceElement and changeElement and arrowElement
    priceElement.textContent = if symbolData.type is 'nft' then "#{formatNumber(newPrice)} ETH" else if symbolData.type in ['stock', 'reit', 'index'] then "$#{formatNumber(newPrice)}" else "#{formatNumber(newPrice)}"
    changeElement.textContent = "#{if change >= 0 then '+' else ''}#{change}%"
    changeElement.className = if change >= 0 then 'text-green-500' else 'text-red-500'
    arrowElement.innerHTML = if change >= 0
      '<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 15l7-7 7 7"/>'
    else
      '<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"/>'
    arrowElement.className = "w-3 h-3 #{if change >= 0 then 'text-green-500' else 'text-red-500'}"

    chart = Chart.getChart("chart-#{symbolData.symbol.toLowerCase()}")
    if chart
      chartData = Array(5).fill(0).map((_, i) -> newPrice * (1 + (Math.random() * 0.02 - 0.01)))
      chart.data.datasets[0].data = if symbolData.type is 'nft'
        chartData
      else
        chartData.map((price, i) -> { t: i, o: price * 0.99, h: price * 1.01, l: price * 0.98, c: price })
      chart.update()
  else
    console.warn "DOM elements for #{symbolData.symbol} not found (price, change, or arrow)"

# Initialize Charts
initializeCharts = ->
  console.log "Initializing charts for #{SYMBOLS.length} symbols"
  for symbolData in SYMBOLS
    ctx = document.getElementById("chart-#{symbolData.symbol.toLowerCase()}")
    if ctx
      chartData = Array(5).fill(0).map((_, i) -> symbolData.basePrice * (1 + (Math.random() * 0.02 - 0.01)))
      color = if symbolData.change >= 0 then '#34d399' else '#ef4444'
      if symbolData.type is 'nft'
        createLineChart(ctx, chartData, color)
      else
        createCandlestickChart(ctx, chartData.map((price, i) -> { t: i, o: price * 0.99, h: price * 1.01, l: price * 0.98, c: price }), color)
    else
      console.warn "Canvas element for #{symbolData.symbol} not found!"

# Update All Tickers
updateAllTickers = ->
  console.log "Updating all tickers"
  for symbolData in SYMBOLS
    updatePrice(symbolData)
  setTimeout(updateAllTickers, UPDATE_INTERVAL)

# Popup Functionality
setupPopup = ->
  console.log "Setting up popup functionality"
  tickerItems = document.querySelectorAll('.ticker-item')
  console.log "Found #{tickerItems.length} ticker items"

  modal = document.getElementById('ticker-modal')
  if !modal
    console.error "Modal element not found!"
    return

  modalTitle = document.getElementById('modal-title')
  modalClose = document.getElementById('modal-close')
  modalPrice = document.getElementById('modal-price')
  modalChange = document.getElementById('modal-change')
  modalVolume = document.getElementById('modal-volume')
  modalMarketCap = document.getElementById('modal-market-cap')
  modalHigh = document.getElementById('modal-high')
  modalLow = document.getElementById('modal-low')
  modalAvgVolume = document.getElementById('modal-avg-volume')
  modalVolatility = document.getElementById('modal-volatility')
  modalSpecific = document.getElementById('modal-specific')
  modalStoplossLink = document.getElementById('modal-stoploss-link')

  modal.classList.add('hidden')

  for item in tickerItems
    item.addEventListener 'click', (event) ->
      event.stopPropagation()
      console.log "Ticker item clicked: #{item.getAttribute('data-symbol')}"
      symbol = item.getAttribute('data-symbol')
      type = item.getAttribute('data-type')
      symbolData = SYMBOLS.find((s) -> s.symbol is symbol)

      if symbolData
        modalTitle.textContent = switch type
          when 'stock' then "#{symbol} Stock"
          when 'exchange' then "NYSE Composite (#{symbol})"
          when 'reit' then "Vanguard REIT ETF (#{symbol})"
          when 'commodity' then "#{symbol} Futures"
          when 'index' then "#{symbol} ETF"
          when 'crypto' then "#{symbol} Crypto"
          when 'nft' then "Bored Ape Yacht Club (#{symbol})"
          else symbol

        modalPrice.textContent = "Price: #{document.querySelector("#price-#{symbol.toLowerCase()}").textContent}"
        modalChange.textContent = "24h Change: #{document.querySelector("#change-#{symbol.toLowerCase()}").textContent}"
        modalVolume.textContent = "Volume: #{symbolData.volume}"
        modalMarketCap.textContent = symbolData.specific if symbolData.specific.includes('Market Cap') or symbolData.specific.includes('Assets')
        modalHigh.textContent = "24h High: #{formatNumber(symbolData.basePrice * 1.02)}"
        modalLow.textContent = "24h Low: #{formatNumber(symbolData.basePrice * 0.98)}"
        modalAvgVolume.textContent = "Avg Volume: #{symbolData.volume}"
        modalVolatility.textContent = "Volatility: #{(Math.random() * 5).toFixed(2)}%"
        modalSpecific.textContent = symbolData.specific unless symbolData.specific.includes('Market Cap') or symbolData.specific.includes('Assets')
        modalStoplossLink.href = "https://stoploss.com/#{symbol.toLowerCase()}"

        chartData = Array(10).fill(0).map((_, i) -> symbolData.basePrice * (1 + (Math.random() * 0.05 - 0.025)))
        createDetailedChart(document.getElementById('modal-chart'), chartData, if symbolData.change >= 0 then '#34d399' else '#ef4444')

        detailedChartData = Array(20).fill(0).map((_, i) -> symbolData.basePrice * (1 + (Math.random() * 0.1 - 0.05)))
        createDetailedChart(document.getElementById('modal-detailed-chart'), detailedChartData, if symbolData.change >= 0 then '#34d399' else '#ef4444')
        volumeData = Array(20).fill(0).map((_, i) -> parseFloat(symbolData.volume.replace(/[^0-9.]/g, '')) * (Math.random() * 0.5 + 0.5))
        createVolumeChart(document.getElementById('modal-volume-chart'), volumeData)

        bidElement = document.getElementById('modal-bid')
        askElement = document.getElementById('modal-ask')
        bidElement.innerHTML = ''
        askElement.innerHTML = ''
        for i in [1..5]
          bidPrice = (symbolData.basePrice * (1 - i * 0.001)).toFixed(2)
          askPrice = (symbolData.basePrice * (1 + i * 0.001)).toFixed(2)
          bidElement.innerHTML += "<p>#{bidPrice} - #{Math.round(Math.random() * 1000)} shares</p>"
          askElement.innerHTML += "<p>#{askPrice} - #{Math.round(Math.random() * 1000)} shares</p>"

        newsElement = document.getElementById('modal-news')
        newsElement.innerHTML = ''
        newsItems = [
          'Q3 earnings beat expectations.'
          'New product launch announced.'
          'Analyst upgrades stock to Buy.'
          'Market volatility impacts price.'
          'Dividend increase reported.'
        ]
        for news in newsItems
          newsElement.innerHTML += "<p>#{news} - #{new Date().toLocaleTimeString()}</p>"

        indicators1 = document.getElementById('modal-indicators-1')
        indicators2 = document.getElementById('modal-indicators-2')
        indicators1.innerHTML = ''
        indicators2.innerHTML = ''
        indicators = [
          "RSI: #{symbolData.rsi or (Math.random() * 100).toFixed(0)}"
          "MACD: #{symbolData.macd or (Math.random() * 2 - 1).toFixed(2)}"
          "Bollinger Bands: #{symbolData.bollinger or (Math.random() * 3).toFixed(2)}"
          "Stochastic: #{(Math.random() * 100).toFixed(0)}"
          "ADX: #{(Math.random() * 50).toFixed(0)}"
          "CCI: #{(Math.random() * 200 - 100).toFixed(0)}"
          "ATR: #{(Math.random() * 5).toFixed(2)}"
          "OBV: #{formatNumber(Math.random() * 1e9)}"
          "VWAP: #{formatNumber(symbolData.basePrice * 1.01)}"
          "Ichimoku: #{(Math.random() * 100).toFixed(0)}"
          "Momentum: #{(Math.random() * 10 - 5).toFixed(2)}"
        ]
        for i in [0..4]
          indicators1.innerHTML += "<p>#{indicators[i]}</p>"
        for i in [5..10]
          indicators2.innerHTML += "<p>#{indicators[i]}</p>"

        console.log "Showing modal for #{symbol}"
        modal.classList.remove('hidden')

  modalClose.addEventListener 'click', (event) ->
    event.stopPropagation()
    console.log "Closing modal via close button"
    modal.classList.add('hidden')

  modal.addEventListener 'click', (event) ->
    if event.target is modal
      console.log "Closing modal by clicking outside"
      modal.classList.add('hidden')

  tabButtons = document.querySelectorAll('.tab-button')
  tabContents = document.querySelectorAll('.tab-content')
  for button in tabButtons
    button.addEventListener 'click', (event) ->
      event.stopPropagation()
      tab = button.getAttribute('data-tab')
      console.log "Switching to tab: #{tab}"
      for btn in tabButtons
        btn.classList.remove('active')
      button.classList.add('active')
      for content in tabContents
        content.classList.add('hidden')
      document.getElementById("tab-#{tab}").classList.remove('hidden')

# Initialize on DOM Load
document.addEventListener 'DOMContentLoaded', ->
  console.log "DOM fully loaded, initializing ticker"
  try
    tickerItems = document.querySelectorAll('.ticker-item')
    console.log "Found #{tickerItems.length} ticker items in DOM"
    if tickerItems.length > 0
      initializeCharts()
      updateAllTickers()
      setupPopup()
    else
      console.error "No ticker items found in DOM! Check ticker.html.twig."
  catch error
    console.error "Ticker initialization failed:", error
