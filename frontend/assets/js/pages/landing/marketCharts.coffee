# Sample data for candlestick charts (simplified for demonstration)
cryptoData =
  btc: [
    { t: '2025-05-01', o: 60000, h: 62000, l: 59000, c: 61000 }
    { t: '2025-05-02', o: 61000, h: 63000, l: 60000, c: 62000 }
  ]
  eth: [
    { t: '2025-05-01', o: 3000, h: 3100, l: 2900, c: 3050 }
    { t: '2025-05-02', o: 3050, h: 3150, l: 2950, c: 3100 }
  ]
  avy: [
    { t: '2025-05-01', o: 10, h: 12, l: 9, c: 11 }
    { t: '2025-05-02', o: 11, h: 13, l: 10, c: 12 }
  ]

nftData =
  bayc: [
    { t: '2025-05-01', o: 50, h: 55, l: 48, c: 52 }
    { t: '2025-05-02', o: 52, h: 57, l: 50, c: 54 }
  ]
  punks: [
    { t: '2025-05-01', o: 70, h: 75, l: 68, c: 72 }
    { t: '2025-05-02', o: 72, h: 77, l: 70, c: 74 }
  ]
  azuki: [
    { t: '2025-05-01', o: 30, h: 35, l: 28, c: 32 }
    { t: '2025-05-02', o: 32, h: 37, l: 30, c: 34 }
  ]

stockData =
  sp500: [
    { t: '2025-05-01', o: 5000, h: 5050, l: 4950, c: 5020 }
    { t: '2025-05-02', o: 5020, h: 5070, l: 4970, c: 5040 }
  ]
  dow: [
    { t: '2025-05-01', o: 38000, h: 38500, l: 37500, c: 38200 }
    { t: '2025-05-02', o: 38200, h: 38700, l: 37700, c: 38400 }
  ]
  nasdaq: [
    { t: '2025-05-01', o: 15000, h: 15200, l: 14800, c: 15100 }
    { t: '2025-05-02', o: 15100, h: 15300, l: 14900, c: 15200 }
  ]

globalData =
  nikkei: [
    { t: '2025-05-01', o: 38000, h: 38500, l: 37500, c: 38200 }
    { t: '2025-05-02', o: 38200, h: 38700, l: 37700, c: 38400 }
  ]
  ftse: [
    { t: '2025-05-01', o: 8000, h: 8100, l: 7900, c: 8050 }
    { t: '2025-05-02', o: 8050, h: 8150, l: 7950, c: 8100 }
  ]
  dax: [
    { t: '2025-05-01', o: 18000, h: 18200, l: 17800, c: 18100 }
    { t: '2025-05-02', o: 18100, h: 18300, l: 17900, c: 18200 }
  ]

# Function to create a candlestick chart
createChart = (canvasId, data, label) ->
  ctx = document.getElementById(canvasId).getContext('2d')
  new Chart(ctx, {
    type: 'candlestick',
    data: {
      datasets: [{
        label: label,
        data: data.map (d) -> { x: d.t, o: d.o, h: d.h, l: d.l, c: d.c }
      }]
    },
    options: {
      scales: {
        x: { type: 'time', time: { unit: 'day' } }
        y: { beginAtZero: false }
      }
    }
  })

# Initialize charts when DOM is loaded
document.addEventListener 'DOMContentLoaded', ->
  # Crypto Charts
  createChart 'chart-btc', cryptoData.btc, 'Bitcoin (BTC)'
  createChart 'chart-eth', cryptoData.eth, 'Ethereum (ETH)'
  createChart 'chart-avy', cryptoData.avy, 'AVY Token'

  # NFT Charts
  createChart 'chart-nft-bayc', nftData.bayc, 'Bored Ape Yacht Club'
  createChart 'chart-nft-punks', nftData.punks, 'CryptoPunks'
  createChart 'chart-nft-azuki', nftData.azuki, 'Azuki'

  # Stock Market Charts
  createChart 'chart-sp500', stockData.sp500, 'S&P 500'
  createChart 'chart-dow', stockData.dow, 'Dow Jones'
  createChart 'chart-nasdaq', stockData.nasdaq, 'NASDAQ'

  # Global Markets Charts
  createChart 'chart-nikkei', globalData.nikkei, 'Nikkei 225'
  createChart 'chart-ftse', globalData.ftse, 'FTSE 100'
  createChart 'chart-dax', globalData.dax, 'DAX'
