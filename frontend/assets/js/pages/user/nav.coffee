document.addEventListener 'DOMContentLoaded', ->
  tabButtons = document.querySelectorAll '.tab-btn'
  menuBtn = document.getElementById 'menu-btn'
  menuDropdown = document.getElementById 'menu-dropdown'

  updateNav = ->
    width = window.innerWidth
    if width < 1024
      menuDropdown.classList.remove 'hidden'
      menuDropdown.innerHTML = ''
      extraTabs = ['user', 'ai']
      for tab in extraTabs
        menuDropdown.innerHTML += "<a href='#' class='block px-4 py-2 text-gray-300 hover:bg-gray-700' data-tab='#{tab}'>#{tab.charAt(0).toUpperCase() + tab.slice(1)}</a>"
    else
      menuDropdown.classList.add 'hidden'
      menuDropdown.innerHTML = "<a href='#' class='block px-4 py-2 text-gray-300 hover:bg-gray-700'>Saves</a>"

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
      updateSidebar tab if typeof updateSidebar == 'function'
  document.querySelector('.tab-btn[data-tab="post"]').click()

  menuBtn.addEventListener 'click', (e) ->
    menuDropdown.classList.toggle 'hidden'

  window.addEventListener 'resize', updateNav
  updateNav() # Initial call
