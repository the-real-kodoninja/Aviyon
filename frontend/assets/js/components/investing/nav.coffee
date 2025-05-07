init = ->
  tabs = document.querySelectorAll '.nav-tab'
  sections = document.querySelectorAll '.content-sections .section'

  console.log 'Initializing nav with tabs:', tabs, 'sections:', sections

  # Show the first section and set the first tab as active on load
  if sections.length > 0 and tabs.length > 0
    sections[0].classList.remove 'hidden'
    tabs[0].classList.add 'active-tab'
    console.log 'Default section shown:', sections[0].id

  tabs.forEach (tab) ->
    tab.addEventListener 'click', (e) ->
      e.preventDefault()
      targetId = tab.getAttribute('href').substring(1)
      targetSection = document.getElementById(targetId)

      console.log 'Clicked tab for:', targetId, 'targetSection:', targetSection

      unless targetSection
        console.error 'Target section not found for:', targetId
        return

      # Hide all sections
      sections.forEach (section) ->
        section.classList.add 'hidden'

      # Show the target section
      targetSection.classList.remove 'hidden'

      # Highlight active tab
      tabs.forEach (t) ->
        t.classList.remove 'active-tab'
      tab.classList.add 'active-tab'
      console.log 'Active section:', targetSection.id

document.addEventListener 'DOMContentLoaded', init

module.exports = { init }
