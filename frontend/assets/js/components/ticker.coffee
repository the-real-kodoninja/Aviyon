# Constants
UPDATE_INTERVAL = 45000  # 45 seconds
SYMBOLS = [
  { symbol: 'AAPL', type: 'stock', basePrice: 175.32, change: 2.3, volume: '45M', rsi: 65, specific: 'Market Cap: $2.8T' }
  { symbol: 'NYSE', type: 'exchange', basePrice: 18450.32, change: -0.8, volume: '3.2B', topGainer: 5.2, specific: 'Top Gainer: +5.2%' }
  { symbol: 'VNQ', type: 'reit', basePrice: 90.45, change: 1.5, yield: 3.8, macd: 0.5, specific: 'Dividend Yield: 3.8%' }
  { symbol: 'GOLD', type: 'commodity', basePrice: 2350.60, change: 0.9, volume: '120K', openInterest: '450K', specific: 'Open Interest: 450K' }
  { symbol: 'SPY', type: 'index', basePrice: 510.25, change: -1.2, volume: '80M', bollinger: 1.2, specific: 'Assets: $400B' }
  { symbol: 'BTC', type: 'crypto', basePrice: 62450, change: 3.1, volume: '$35B', dominance: 54, specific: 'Market Cap: $1.2T' }
  { symbol: 'BAYC', type: 'nft', basePrice: 50, change: -2.5, volume: '120 ETH', owners: '6.5K', specific: 'Owners: 6,500' }
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
  change = (Math.random() * 4 - 2).toFixed(2)  # Random change between -2% and +2%
  priceChange = symbolData.basePrice * (change / 100)
  newPrice = symbolData.basePrice + priceChange
  symbolData.basePrice = newPrice
  symbolData.change = parseFloat(change)

  priceElement = document.querySelector("#price-#{symbolData.symbol.toLowerCase()}")
  changeElement = document.querySelector("#change-#{symbolData.symbol.toLowerCase()}")
  arrowElement = document.querySelector("#arrow-#{symbolData.symbol.toLowerCase()}")

  priceElement.textContent = if symbolData.type is 'nft' then "#{formatNumber(newPrice)} ETH" else if symbolData.type in ['stock', 'reit', 'index'] then "$#{formatNumber(newPrice)}" else "#{formatNumber(newPrice)}"
  changeElement.textContent = "#{if change >= 0 then '+' else ''}#{change}%"
  changeElement.className = if change >= 0 then 'text-green-500' else 'text-red-500'
  arrowElement.innerHTML = if change >= 0
    '<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 15l7-7 7 7"/>'
  else
    '<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"/>'
  arrowElement.className = "w-3 h-3 #{if change >= 0 then 'text-green-500' else 'text-red-500'}"

  # Update chart
  chartData = Array(5).fill(0).map((_, i) -> newPrice * (1 + (Math.random() * 0.02 - 0.01)))
  chart = Chart.getChart("chart-#{symbolData.symbol.toLowerCase()}")
  if chart
    chart.data.datasets[0].data = if symbolData.type is 'nft'
      chartData
    else
      chartData.map((price, i) -> { t: i, o: price * 0.99, h: price * 1.01, l: price * 0.98, c: price })
    chart.update()

# Initialize Charts
initializeCharts = ->
  for symbolData in SYMBOLS
    ctx = document.getElementById("chart-#{symbolData.symbol.toLowerCase()}")
    chartData = Array(5).fill(0).map((_, i) -> symbolData.basePrice * (1 + (Math.random() * 0.02 - 0.01)))
    color = if symbolData.change >= 0 then '#34d399' else '#ef4444'
    if symbolData.type is 'nft'
      createLineChart(ctx, chartData, color)
    else
      createCandlestickChart(ctx, chartData.map((price, i) -> { t: i, o: price * 0.99, h: price * 1.01, l: price * 0.98, c: price }), color)

# Update All Tickers
updateAllTickers = ->
  for symbolData in SYMBOLS
    updatePrice(symbolData)
  setTimeout(updateAllTickers, UPDATE_INTERVAL)

# Popup Functionality
setupPopup = ->
  tickerItems = document.querySelectorAll('.ticker-item')
  modal = document.getElementById('ticker-modal')
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

  # Ensure modal is initially hidden
  modal.classList.add('hidden')

  for item in tickerItems
    # Add click event listener to each ticker item
    item.addEventListener 'click', (event) ->
      event.stopPropagation()  # Prevent event bubbling
      symbol = @getAttribute('data-symbol')
      type = @getAttribute('data-type')
      symbolData = SYMBOLS.find((s) -> s.symbol is symbol)

      if symbolData
        # Populate modal content
        modalTitle.textContent = switch type
          when 'stock' then "Apple Inc. (#{symbol})"
          when 'exchange' then "NYSE Composite (#{symbol})"
          when 'reit' then "Vanguard REIT ETF (#{symbol})"
          when 'commodity' then "Gold Futures (#{symbol})"
          when 'index' then "S&P 500 ETF (#{symbol})"
          when 'crypto' then "Bitcoin (#{symbol})"
          when 'nft' then "Bored Ape Yacht Club (#{symbol})"

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

        # Overview Chart
        chartData = Array(10).fill(0).map((_, i) -> symbolData.basePrice * (1 + (Math.random() * 0.05 - 0.025)))
        createDetailedChart(document.getElementById('modal-chart'), chartData, if symbolData.change >= 0 then '#34d399' else '#ef4444')

        # Detailed Chart Tab
        detailedChartData = Array(20).fill(0).map((_, i) -> symbolData.basePrice * (1 + (Math.random() * 0.1 - 0.05)))
        createDetailedChart(document.getElementById('modal-detailed-chart'), detailedChartData, if symbolData.change >= 0 then '#34d399' else '#ef4444')
        volumeData = Array(20).fill(0).map((_, i) -> parseFloat(symbolData.volume) * (Math.random() * 0.5 + 0.5))
        createVolumeChart(document.getElementById('modal-volume-chart'), volumeData)

        # Level 2 Data
        bidElement = document.getElementById('modal-bid')
        askElement = document.getElementById('modal-ask')
        bidElement.innerHTML = ''
        askElement.innerHTML = ''
        for i in [1..5]
          bidPrice = (symbolData.basePrice * (1 - i * 0.001)).toFixed(2)
          askPrice = (symbolData.basePrice * (1 + i * 0.001)).toFixed(2)
          bidElement.innerHTML += "<p>#{bidPrice} - #{Math.round(Math.random() * 1000)} shares</p>"
          askElement.innerHTML += "<p>#{askPrice} - #{Math.round(Math.random() * 1000)} shares</p>"

        # News
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

        # Indicators
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

        # Show the modal
        modal.classList.remove('hidden')

  # Close modal when clicking the close button
  modalClose.addEventListener 'click', (event) ->
    event.stopPropagation()
    modal.classList.add('hidden')

  # Close modal when clicking outside
  modal.addEventListener 'click', (event) ->
    if event.target is modal
      modal.classList.add('hidden')

  # Tab Switching
  tabButtons = document.querySelectorAll('.tab-button')
  tabContents = document.querySelectorAll('.tab-content')
  for button in tabButtons
    button.addEventListener 'click', (event) ->
      event.stopPropagation()
      tab = @getAttribute('data-tab')
      for btn in tabButtons
        btn.classList.remove('active')
      @classList.add('active')
      for content in tabContents
        content.classList.add('hidden')
      document.getElementById("tab-#{tab}").classList.remove('hidden')

# Initialize on DOM Load
document.addEventListener 'DOMContentLoaded', ->
  initializeCharts()
  updateAllTickers()
  setupPopup()
