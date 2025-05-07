init = ->
  followButtons = document.querySelectorAll '.follow-btn'
  followButtons.forEach (btn) ->
    btn.addEventListener 'click', ->
      trader = btn.dataset.trader
      btn.textContent = "Following #{trader}"
      btn.classList.remove 'bg-neon-purple'
      btn.classList.add 'bg-gray-500'

module.exports = { init }
