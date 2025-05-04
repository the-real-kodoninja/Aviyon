document.addEventListener 'DOMContentLoaded', ->
  tabButtons = document.querySelectorAll '.tab-btn'
  for button in tabButtons
    button.addEventListener 'click', (e) ->
      tab = e.target.getAttribute 'data-tab'
      for btn in tabButtons
        btn.classList.remove 'text-purple-400', 'border-purple-400'
      e.target.classList.add 'text-purple-400', 'border-purple-400'
      tabs = document.querySelectorAll '[id]'
      for t in tabs
        t.classList.add 'hidden'
      document.getElementById(tab).classList.remove 'hidden'
  # Set initial tab with hover color as selected
  initialTab = document.querySelector('.tab-btn[data-tab="post"]')
  initialTab.classList.add 'text-purple-400', 'border-purple-400'
  document.getElementById('post').classList.remove 'hidden'
