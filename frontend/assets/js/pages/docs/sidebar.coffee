document.addEventListener 'DOMContentLoaded', ->
  toggleButtons = document.querySelectorAll '.toggle-section'
  docLinks = document.querySelectorAll '.doc-link'
  docContent = document.getElementById 'doc-content'

  # Toggle Section Collapsing with Animation
  toggleButtons.forEach (button) ->
    button.addEventListener 'click', (e) ->
      e.preventDefault()
      content = button.nextElementSibling
      arrow = button.querySelector 'svg'
      if content.classList.contains 'hidden'
        content.classList.remove 'hidden'
        content.classList.add 'animate__animated', 'animate__fadeInDown'
        arrow.classList.add 'rotate-180'
      else
        content.classList.add 'animate__animated', 'animate__fadeOutUp'
        content.addEventListener 'animationend', ->
          content.classList.add 'hidden'
        , once: true
        arrow.classList.remove 'rotate-180'

  # Load Markdown Content on Link Click
  docLinks.forEach (link) ->
    link.addEventListener 'click', (e) ->
      e.preventDefault()
      file = link.dataset.mdFile
      loadMarkdown file
      # Update active link
      docLinks.forEach (l) -> l.classList.remove 'active'
      link.classList.add 'active'
      # Animate content transition
      docContent.classList.add 'animate__animated', 'animate__fadeIn'
