# assets/js/components/ticker.coffee

# Import Chart.js (available globally via CDN)
Chart = window.Chart

# Sample data (30 items) for stocks, crypto, indexes, etc.
SYMBOLS = [
  { symbol: 'AAPL', type: 'stock', price: 175.32, change: 2.3, volume: '45M', rsi: 65, specific: 'Market Cap: $2.8T' }
  { symbol: 'MSFT', type: 'stock', price: 420.45, change: -0.5, volume: '30M', rsi: 70, specific: 'Market Cap: $3.1T' }
  { symbol: 'GOOGL', type: 'stock', price: 150.25, change: 1.8, volume: '25M', rsi: 62, specific: 'Market Cap: $1.9T' }
  { symbol: 'AMZN', type: 'stock', price: 185.67, change: -1.2, volume: '40M', rsi: 58, specific: 'Market Cap: $1.9T' }
  { symbol: 'TSLA', type: 'stock', price: 265.89, change: 3.5, volume: '50M', rsi: 75, specific: 'Market Cap: $850B' }
  { symbol: 'NVDA', type: 'stock', price: 870.12, change: 2.1, volume: '35M', rsi: 80, specific: 'Market Cap: $2.2T' }
  { symbol: 'META', type: 'stock', price: 495.34, change: -0.9, volume: '20M', rsi: 60, specific: 'Market Cap: $1.3T' }
  { symbol: 'JPM', type: 'stock', price: 195.78, change: 0.7, volume: '15M', rsi: 55, specific: 'Market Cap: $570B' }
  { symbol: 'V', type: 'stock', price: 275.56, change: 1.3, volume: '10M', rsi: 63, specific: 'Market Cap: $560B' }
  { symbol: 'WMT', type: 'stock', price: 60.23, change: -0.3, volume: '25M', rsi: 52, specific: 'Market Cap: $485B' }
  { symbol: 'DIS', type: 'stock', price: 115.89, change: 0.9, volume: '18M', rsi: 57, specific: 'Market Cap: $210B' }
  { symbol: 'NFLX', type: 'stock', price: 625.45, change: -1.5, volume: '12M', rsi: 64, specific: 'Market Cap: $270B' }
  { symbol: 'AMD', type: 'stock', price: 165.78, change: 2.7, volume: '30M', rsi: 72, specific: 'Market Cap: $210B' }
  { symbol: 'INTC', type: 'stock', price: 40.12, change: -0.8, volume: '22M', rsi: 48, specific: 'Market Cap: $170B' }
  { symbol: 'CSCO', type: 'stock', price: 50.34, change: 0.4, volume: '15M', rsi: 53, specific: 'Market Cap: $205B' }
  { symbol: 'BTC', type: 'crypto', price: 62450.00, change: 3.1, volume: '$35B', dominance: 54, specific: 'Market Cap: $1.2T' }
  { symbol: 'ETH', type: 'crypto', price: 3250.75, change: -0.6, volume: '$15B', dominance: 18, specific: 'Market Cap: $390B' }
  { symbol: 'BNB', type: 'crypto', price: 580.23, change: 1.9, volume: '$2B', dominance: 4, specific: 'Market Cap: $87B' }
  { symbol: 'ADA', type: 'crypto', price: 0.58, change: -2.1, volume: '$500M', dominance: 1, specific: 'Market Cap: $20B' }
  { symbol: 'XRP', type: 'crypto', price: 0.62, change: 0.8, volume: '$1B', dominance: 1.5, specific: 'Market Cap: $34B' }
  { symbol: 'SOL', type: 'crypto', price: 175.45, change: 2.3, volume: '$3B', dominance: 2, specific: 'Market Cap: $78B' }
  { symbol: 'DOGE', type: 'crypto', price: 0.18, change: -1.7, volume: '$800M', dominance: 0.5, specific: 'Market Cap: $25B' }
  { symbol: 'SPY', type: 'index', price: 510.25, change: -1.2, volume: '80M', bollinger: 1.2, specific: 'Assets: $400B' }
  { symbol: 'DIA', type: 'index', price: 385.67, change: 0.5, volume: '40M', bollinger: 1.0, specific: 'Assets: $350B' }
  { symbol: 'QQQ', type: 'index', price: 435.89, change: -0.9, volume: '50M', bollinger: 1.5, specific: 'Assets: $200B' }
  { symbol: 'IWM', type: 'index', price: 205.34, change: 1.1, volume: '30M', bollinger: 1.3, specific: 'Assets: $60B' }
  { symbol: 'GOLD', type: 'commodity', price: 2350.60, change: 0.9, volume: '120K', openInterest: '450K', specific: 'Open Interest: 450K' }
  { symbol: 'OIL', type: 'commodity', price: 85.23, change: -0.4, volume: '200K', openInterest: '600K', specific: 'Open Interest: 600K' }
  { symbol: 'SILVER', type: 'commodity', price: 27.45, change: 1.2, volume: '150K', openInterest: '300K', specific: 'Open Interest: 300K' }
  { symbol: 'CORN', type: 'commodity', price: 450.78, change: -0.7, volume: '80K', openInterest: '200K', specific: 'Open Interest: 200K' }
]

Ticker =
  init: ->
    @container = document.querySelector '#ticker-items'
    unless @container
      console.error 'Ticker container not found!'
      return

    # Fetch real-time data
    @fetchRealTimeData()

  fetchRealTimeData: ->
    fetch '/api/ticker',
      method: 'GET'
      headers:
        'Accept': 'application/json'
    .then (response) =>
      if response.ok
        response.json().then (data) =>
          # Map API data to include additional fields
          @items = data.map (item) ->
            switch item.type
              when 'stock'
                item.volume = "#{Math.round(Math.random() * 50)}M"
                item.rsi = Math.round(Math.random() * 100)
                item.specific = "Market Cap: $#{Math.round(Math.random() * 3000)}B"
              when 'crypto'
                item.volume = "$#{Math.round(Math.random() * 35)}B"
                item.dominance = Math.round(Math.random() * 60)
                item.specific = "Market Cap: $#{Math.round(Math.random() * 1200)}B"
              when 'index'
                item.volume = "#{Math.round(Math.random() * 80)}M"
                item.bollinger = (Math.random() * 2).toFixed(1)
                item.specific = "Assets: $#{Math.round(Math.random() * 400)}B"
              when 'commodity'
                item.volume = "#{Math.round(Math.random() * 200)}K"
                item.openInterest = "#{Math.round(Math.random() * 600)}K"
                item.specific = "Open Interest: #{Math.round(Math.random() * 600)}K"
            item
          @items = @items.concat @items # Duplicate for infinite scrolling
          @renderItems()
          @initializeCharts()
          @startScrolling()
          @setupPopup()
      else
        console.error 'Failed to fetch ticker data'
        # Fallback to static data
        @items = SYMBOLS.concat SYMBOLS
        @renderItems()
        @initializeCharts()
        @startScrolling()
        @setupPopup()

  renderItems: ->
    # Clear container
    @container.innerHTML = ''

    # Add items
    for item in @items
      changeClass = if item.change >= 0 then 'text-green-500' else 'text-red-500'
      arrowPath = if item.change >= 0
        'M5 15l7-7 7 7'
      else
        'M19 9l-7 7-7-7'
      priceFormatted = switch item.type
        when 'crypto' then "#{item.price.toFixed(2)}"
        when 'commodity' then "#{item.price.toFixed(2)}"
        when 'nft' then "#{item.price} ETH"
        else "$#{item.price.toFixed(2)}"

      # Determine metrics based on type
      metric1 = switch item.type
        when 'stock' then "Vol: #{item.volume}"
        when 'crypto' then "Vol: #{item.volume}"
        when 'index' then "Vol: #{item.volume}"
        when 'commodity' then "Vol: #{item.volume}"
        when 'nft' then "Vol: #{item.volume}"
        when 'exchange' then "Vol: #{item.volume}"
        when 'reit' then "Yield: #{item.yield or '3.8%'}"
        else "Vol: N/A"

      metric2 = switch item.type
        when 'stock' then "RSI: #{item.rsi or 65}"
        when 'crypto' then "Dom: #{item.dominance or 54}%"
        when 'index' then "BB: #{item.bollinger or 1.2}"
        when 'commodity' then "OI: #{item.openInterest or '450K'}"
        when 'nft' then "Own: #{item.owners or '6.5K'}"
        when 'exchange' then "Top: +#{item.topGainer or 5.2}%"
        when 'reit' then "MACD: #{item.macd or 0.5}"
        else "N/A"

      # Special case for NFT (include image)
      imageTag = if item.type is 'nft'
        """<img src="/build/images/nfts/#{item.symbol.toLowerCase()}.jpg" alt="#{item.symbol}" class="w-6 h-6 rounded">"""
      else
        """<span class="text-gray-300 font-semibold">#{item.symbol}</span>"""

      itemHtml = """
        <div class="relative ticker-item" data-symbol="#{item.symbol}" data-type="#{item.type}">
          <div class="flex items-center space-x-1 bg-gray-950 p-1 rounded-lg cursor-pointer text-xs h-10 w-48 overflow-hidden">
            #{imageTag}
            <canvas id="chart-#{item.symbol.toLowerCase()}" class="w-12 h-6"></canvas>
            <div class="flex flex-col items-center">
              <span id="price-#{item.symbol.toLowerCase()}" class="text-gray-300">#{priceFormatted}</span>
              <div class="flex items-center space-x-1">
                <span id="change-#{item.symbol.toLowerCase()}" class="#{changeClass}">#{if item.change >= 0 then '+' else ''}#{item.change}%</span>
                <svg id="arrow-#{item.symbol.toLowerCase()}" class="w-3 h-3 #{changeClass}" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="#{arrowPath}"></path>
                </svg>
              </div>
            </div>
            <div class="flex flex-col text-gray-400 text-[10px]">
              <span>#{metric1}</span>
              <span>#{metric2}</span>
            </div>
          </div>
        </div>
      """
      @container.insertAdjacentHTML 'beforeend', itemHtml

  initializeCharts: ->
    for item in @items
      ctx = document.getElementById "chart-#{item.symbol.toLowerCase()}"
      if ctx
        chartData = Array(5).fill(0).map (__, i) -> item.price * (1 + (Math.random() * 0.02 - 0.01))
        color = if item.change >= 0 then '#34d399' else '#ef4444'
        new Chart ctx,
          type: 'line'
          data:
            labels: Array(chartData.length).fill('')
            datasets: [
              data: chartData
              borderColor: color
              backgroundColor: 'transparent'
              borderWidth: 1
              pointRadius: 0
            ]
          options:
            responsive: true
            scales:
              x: display: false
              y: display: false
            plugins:
              legend: display: false
              tooltip: enabled: false

  startScrolling: ->
    # Calculate total width of items
    itemWidth = 192 # w-48 (48 * 4px = 192px)
    totalItems = @items.length
    totalWidth = itemWidth * totalItems

    # Set container width
    @container.style.width = "#{totalWidth}px"

    # Animation
    position = 0
    speed = 0.5 # pixels per frame (adjust for slower/faster scrolling)

    animate = =>
      position -= speed
      if -position >= totalWidth / 2
        position = 0 # Reset to start for infinite loop
      @container.style.transform = "translateX(#{position}px)"
      requestAnimationFrame animate

    requestAnimationFrame animate

  setupPopup: ->
    tickerItems = document.querySelectorAll '.ticker-item'
    modal = document.getElementById 'ticker-modal'
    modalTitle = document.getElementById 'modal-title'
    modalClose = document.getElementById 'modal-close'
    modalPrice = document.getElementById 'modal-price'
    modalChange = document.getElementById 'modal-change'
    modalVolume = document.getElementById 'modal-volume'
    modalMarketCap = document.getElementById 'modal-market-cap'
    modalHigh = document.getElementById 'modal-high'
    modalLow = document.getElementById 'modal-low'
    modalAvgVolume = document.getElementById 'modal-avg-volume'
    modalVolatility = document.getElementById 'modal-volatility'
    modalSpecific = document.getElementById 'modal-specific'
    modalStoplossLink = document.getElementById 'modal-stoploss-link'

    unless modal
      console.error 'Modal element not found!'
      return

    # Ensure modal is initially hidden
    modal.classList.add 'hidden'

    for item in tickerItems
      item.addEventListener 'click', (event) =>
        event.stopPropagation()
        symbol = item.getAttribute 'data-symbol'
        type = item.getAttribute 'data-type'
        itemData = @items.find (s) -> s.symbol is symbol

        if itemData
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
          modalVolume.textContent = "Volume: #{itemData.volume}"
          modalMarketCap.textContent = itemData.specific if itemData.specific?.includes('Market Cap') or itemData.specific?.includes('Assets')
          modalHigh.textContent = "24h High: #{(itemData.price * 1.02).toFixed(2)}"
          modalLow.textContent = "24h Low: #{(itemData.price * 0.98).toFixed(2)}"
          modalAvgVolume.textContent = "Avg Volume: #{itemData.volume}"
          modalVolatility.textContent = "Volatility: #{(Math.random() * 5).toFixed(2)}%"
          modalSpecific.textContent = itemData.specific unless itemData.specific?.includes('Market Cap') or itemData.specific?.includes('Assets')
          modalStoplossLink.href = "https://stoploss.com/#{symbol.toLowerCase()}"

          # Overview Chart
          chartData = Array(10).fill(0).map (__, i) -> itemData.price * (1 + (Math.random() * 0.05 - 0.025))
          new Chart document.getElementById('modal-chart'),
            type: 'line'
            data:
              labels: Array(chartData.length).fill('').map (__, i) -> "-#{chartData.length - 1 - i}m"
              datasets: [
                label: 'Price'
                data: chartData
                borderColor: if itemData.change >= 0 then '#34d399' else '#ef4444'
                backgroundColor: (if itemData.change >= 0 then '#34d399' else '#ef4444') + '33'
                fill: true
                tension: 0.4
              ]
            options:
              responsive: true
              scales:
                y: beginAtZero: false
                x: display: false
              plugins:
                legend: labels: color: '#d1d5db'

          # Detailed Chart Tab
          detailedChartData = Array(20).fill(0).map (__, i) -> itemData.price * (1 + (Math.random() * 0.1 - 0.05))
          new Chart document.getElementById('modal-detailed-chart'),
            type: 'line'
            data:
              labels: Array(detailedChartData.length).fill('').map (__, i) -> "-#{detailedChartData.length - 1 - i}m"
              datasets: [
                label: 'Price'
                data: detailedChartData
                borderColor: if itemData.change >= 0 then '#34d399' else '#ef4444'
                backgroundColor: (if itemData.change >= 0 then '#34d399' else '#ef4444') + '33'
                fill: true
                tension: 0.4
              ]
            options:
              responsive: true
              scales:
                y: beginAtZero: false
                x: display: false
              plugins:
                legend: labels: color: '#d1d5db'

          volumeData = Array(20).fill(0).map (__, i) -> parseFloat(itemData.volume.replace(/[^0-9.]/g, '')) * (Math.random() * 0.5 + 0.5)
          new Chart document.getElementById('modal-volume-chart'),
            type: 'bar'
            data:
              labels: Array(volumeData.length).fill('').map (__, i) -> "-#{volumeData.length - 1 - i}m"
              datasets: [
                label: 'Volume'
                data: volumeData
                backgroundColor: '#8b5cf6'
              ]
            options:
              responsive: true
              scales:
                y: beginAtZero: true
                x: display: false

          # Level 2 Data
          bidElement = document.getElementById 'modal-bid'
          askElement = document.getElementById 'modal-ask'
          bidElement.innerHTML = ''
          askElement.innerHTML = ''
          for i in [1..5]
            bidPrice = (itemData.price * (1 - i * 0.001)).toFixed(2)
            askPrice = (itemData.price * (1 + i * 0.001)).toFixed(2)
            bidElement.innerHTML += "<p>#{bidPrice} - #{Math.round(Math.random() * 1000)} shares</p>"
            askElement.innerHTML += "<p>#{askPrice} - #{Math.round(Math.random() * 1000)} shares</p>"

          # News
          newsElement = document.getElementById 'modal-news'
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
          indicators1 = document.getElementById 'modal-indicators-1'
          indicators2 = document.getElementById 'modal-indicators-2'
          indicators1.innerHTML = ''
          indicators2.innerHTML = ''
          indicators = [
            "RSI: #{itemData.rsi or (Math.random() * 100).toFixed(0)}"
            "MACD: #{itemData.macd or (Math.random() * 2 - 1).toFixed(2)}"
            "Bollinger Bands: #{itemData.bollinger or (Math.random() * 3).toFixed(2)}"
            "Stochastic: #{(Math.random() * 100).toFixed(0)}"
            "ADX: #{(Math.random() * 50).toFixed(0)}"
            "CCI: #{(Math.random() * 200 - 100).toFixed(0)}"
            "ATR: #{(Math.random() * 5).toFixed(2)}"
            "OBV: #{Math.round(Math.random() * 1e9)}"
            "VWAP: #{(itemData.price * 1.01).toFixed(2)}"
            "Ichimoku: #{(Math.random() * 100).toFixed(0)}"
            "Momentum: #{(Math.random() * 10 - 5).toFixed(2)}"
          ]
          for i in [0..4]
            indicators1.innerHTML += "<p>#{indicators[i]}</p>"
          for i in [5..10]
            indicators2.innerHTML += "<p>#{indicators[i]}</p>"

          # Show the modal
          modal.classList.remove 'hidden'

    # Close modal when clicking the close button
    modalClose.addEventListener 'click', (event) ->
      event.stopPropagation()
      modal.classList.add 'hidden'

    # Close modal when clicking outside
    modal.addEventListener 'click', (event) ->
      if event.target is modal
        modal.classList.add 'hidden'

    # Tab Switching
    tabButtons = document.querySelectorAll '.tab-button'
    tabContents = document.querySelectorAll '.tab-content'
    for button in tabButtons
      button.addEventListener 'click', (event) ->
        event.stopPropagation()
        tab = button.getAttribute 'data-tab'
        for btn in tabButtons
          btn.classList.remove 'active'
        button.classList.add 'active'
        for content in tabContents
          content.classList.add 'hidden'
        document.getElementById("tab-#{tab}").classList.remove 'hidden'

document.addEventListener 'DOMContentLoaded', ->
  Ticker.init()
