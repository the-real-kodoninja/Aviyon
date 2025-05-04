document.addEventListener 'DOMContentLoaded', ->
  toggleButtons = document.querySelectorAll '.toggle-section'
  docLinks = document.querySelectorAll '.doc-link'
  docContent = document.getElementById 'doc-content'

  # Toggle Section Collapsing
  toggleButtons.forEach (button) ->
    button.addEventListener 'click', (e) ->
      e.preventDefault()
      content = button.nextElementSibling
      arrow = button.querySelector 'svg'
      content.classList.toggle 'hidden'
      arrow.classList.toggle 'rotate-180'

  # Load Markdown Content on Link Click
  docLinks.forEach (link) ->
    link.addEventListener 'click', (e) ->
      e.preventDefault()
      file = link.dataset.mdFile
      loadMarkdown file
      # Update active link
      docLinks.forEach (l) -> l.classList.remove 'active'
      link.classList.add 'active'

  # Function to load Markdown
  loadMarkdown = (file) ->
    try
      response = await fetch "/docs/#{file}"
      throw new Error('Failed to load Markdown file') unless response.ok
      markdown = await response.text()
      html = marked.parse markdown,
        baseUrl: "/docs/#{file.substring(0, file.lastIndexOf('/'))}/"
        breaks: true
        gfm: true
      docContent.innerHTML = html
    catch error
      console.error 'Error loading Markdown:', error
      docContent.innerHTML = '<p class="text-red-500">Failed to load documentation.</p>'
