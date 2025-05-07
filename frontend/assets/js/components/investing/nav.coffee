init = ->
  console.log 'Nav init started'

  tabs = document.querySelectorAll '.nav-tab'
  sections = document.querySelectorAll '.content-sections .section'

  console.log 'Tabs found:', tabs.length
  console.log 'Sections found:', sections.length

  # Ensure tabs and sections are found
  unless tabs.length > 0
    console.error 'No nav tabs found with class .nav-tab'
    return
  unless sections.length > 0
    console.error 'No sections found with class .content-sections .section'
    return

  # Set up click listeners for each tab
  tabs.forEach (tab, index) ->
    console.log 'Attaching listener to tab:', tab.getAttribute('href')
    tab.addEventListener 'click', (e) ->
      e.preventDefault()
      targetId = tab.getAttribute('href')?.substring(1)
      console.log 'Tab clicked, target ID:', targetId

      unless targetId
        console.error 'No href attribute found on tab:', tab
        return

      targetSection = document.getElementById(targetId)
      unless targetSection
        console.error 'Target section not found for ID:', targetId
        return

      # Hide all sections
      sections.forEach (section) ->
        section.classList.add 'hidden'

      # Show the target section
      targetSection.classList.remove 'hidden'
      console.log 'Showing section:', targetId

      # Update active tab styling
      tabs.forEach (t) ->
        t.classList.remove 'active-tab'
      tab.classList.add 'active-tab'
      console.log 'Active tab updated:', tab.textContent

# Ensure the script runs after DOM is fully loaded
document.addEventListener 'DOMContentLoaded', ->
  console.log 'DOM fully loaded, initializing nav'
  init()

module.exports = { init }
