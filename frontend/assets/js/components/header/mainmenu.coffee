MainMenu =
  getElement: (id) ->
    try
      element = document.getElementById(id)
      throw new Error("Element with ID #{id} not found") unless element
      element
    catch e
      console.error '[MainMenu] Error:', e.message
      null

  toggleDropdown: (toggleId, dropdownId) ->
    toggle = @getElement(toggleId)
    dropdown = @getElement(dropdownId)
    return unless toggle and dropdown

    toggle.addEventListener 'click', (e) =>
      e.stopPropagation()
      dropdown.classList.toggle('hidden')

  init: ->
    # Menu Dropdown
    @toggleDropdown 'aviyon-menu-toggle', 'aviyon-menu-dropdown'

    # Event Delegation
    document.addEventListener 'click', (e) =>
      menuDropdown = @getElement('aviyon-menu-dropdown')
      menuToggle = @getElement('aviyon-menu-toggle')
      if menuDropdown and menuToggle and not menuToggle.contains(e.target) and not menuDropdown.contains(e.target)
        menuDropdown.classList.add('hidden')

      # Ticker Controls
      if e.target.closest('#aviyon-toggle-ticker')
        ticker = @getElement('aviyon-ticker-container')
        ticker.classList.toggle('hidden') if ticker

      if e.target.closest('#aviyon-ticker-prefs')
        modal = @getElement('aviyon-ticker-prefs-modal')
        modal.classList.remove('hidden') if modal

      if e.target.closest('#aviyon-ticker-prefs-close')
        modal = @getElement('aviyon-ticker-prefs-modal')
        modal.classList.add('hidden') if modal

    # Theme Toggle
    themeToggle = @getElement('aviyon-theme-toggle')
    if themeToggle
      themeToggle.addEventListener 'change', (e) =>
        theme = e.target.value
        document.documentElement.classList.remove('dark', 'light', 'earth')
        document.documentElement.classList.add(theme)

document.addEventListener 'DOMContentLoaded', ->
  MainMenu.init()
