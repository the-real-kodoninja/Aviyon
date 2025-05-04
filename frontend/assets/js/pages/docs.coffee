document.addEventListener 'DOMContentLoaded', ->
  docContent = document.getElementById 'doc-content'

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
      docContent.innerHTML = '<p class="text-red-500">Failed to load documentation. Error: ' + error.message + '</p>'

  # Load the first document by default or the active file if passed
  firstLink = document.querySelector '.doc-link'
  if firstLink
    loadMarkdown firstLink.dataset.mdFile
