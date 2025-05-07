init = ->
  sentimentChart = document.getElementById 'sentiment-chart'
  if sentimentChart
    new Chart sentimentChart,
      type: 'doughnut'
      data:
        labels: ['Bullish', 'Bearish', 'Neutral']
        datasets: [
          label: 'Market Sentiment'
          data: [60, 25, 15]
          backgroundColor: ['#10B981', '#EF4444', '#6B7280']
        ]
      options:
        responsive: true
        plugins:
          legend: labels: color: '#F5F5DC'

module.exports = { init }
