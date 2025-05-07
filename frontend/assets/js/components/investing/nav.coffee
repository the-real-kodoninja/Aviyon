init = ->
  tabs = document.querySelectorAll '.nav-tab'
  tabs.forEach (tab) ->
    tab.addEventListener 'click', (e) ->
      e.preventDefault()
      targetId = tab.getAttribute('href').substring(1)
      targetSection = document.getElementById(targetId)
      targetSection.scrollIntoView(behavior: 'smooth')
      
      # Highlight active tab
      tabs.forEach (t) -> t.classList.remove('text-neon-purple')
      tab.classList.add('text-neon-purple')

module.exports = { init }
