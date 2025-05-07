init = ->
  # Tab Switching
  tabs = document.querySelectorAll '.trading-tab'
  contents = document.querySelectorAll '.trading-tab-content'
  tabs.forEach (tab) ->
    tab.addEventListener 'click', ->
      tabs.forEach (t) -> t.classList.remove 'bg-neon-purple', 'text-white'
      tab.classList.add 'bg-neon-purple', 'text-white'
      contents.forEach (content) -> content.classList.add 'hidden'
      document.getElementById("#{tab.dataset.tab}-tab").classList.remove 'hidden'

  # Trade History Chart
  tradeHistoryChart = document.getElementById 'trade-history-chart'
  if tradeHistoryChart
    new Chart tradeHistoryChart,
      type: 'line'
      data:
        labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May']
        datasets: [
          label: 'Profit/Loss ($)'
          data: [5000, 3000, -2000, 4000, 6000]
          borderColor: '#10B981'
          backgroundColor: 'rgba(16, 185, 129, 0.2)'
          fill: true
        ]
      options:
        responsive: true
        scales:
          y:
            beginAtZero: true
            grid: color: '#808000'
            ticks: color: '#F5F5DC'
          x:
            grid: color: '#808000'
            ticks: color: '#F5F5DC'
        plugins:
          legend: labels: color: '#F5F5DC'

  # Trend Pattern Chart
  trendPatternChart = document.getElementById 'trend-pattern-chart'
  if trendPatternChart
    new Chart trendPatternChart,
      type: 'bar'
      data:
        labels: ['Breakout', 'Reversal', 'Consolidation']
        datasets: [
          label: 'Occurrences'
          data: [15, 10, 8]
          backgroundColor: '#8B4513'
        ]
      options:
        responsive: true
        scales:
          y:
            beginAtZero: true
            grid: color: '#808000'
            ticks: color: '#F5F5DC'
          x:
            grid: color: '#808000'
            ticks: color: '#F5F5DC'
        plugins:
          legend: labels: color: '#F5F5DC'

module.exports = { init }
