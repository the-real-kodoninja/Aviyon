init = ->
  portfolio = {}
  portfolioDiv = document.getElementById 'simulator-portfolio'

  updatePortfolio = ->
    portfolioDiv.innerHTML = ''
    for symbol, amount of portfolio
      portfolioDiv.innerHTML += "<p>#{symbol}: $#{amount}</p>"

  document.getElementById('simulator-buy').addEventListener 'click', ->
    symbol = document.getElementById('simulator-symbol').value.toUpperCase()
    amount = parseFloat(document.getElementById('simulator-amount').value) || 0
    if symbol and amount > 0
      portfolio[symbol] = (portfolio[symbol] || 0) + amount
      updatePortfolio()

  document.getElementById('simulator-sell').addEventListener 'click', ->
    symbol = document.getElementById('simulator-symbol').value.toUpperCase()
    amount = parseFloat(document.getElementById('simulator-amount').value) || 0
    if symbol and amount > 0 and portfolio[symbol]
      portfolio[symbol] -= amount
      if portfolio[symbol] <= 0
        delete portfolio[symbol]
      updatePortfolio()

module.exports = { init }
