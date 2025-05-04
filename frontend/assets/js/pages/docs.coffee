document.addEventListener 'DOMContentLoaded', ->
  docContent = document.getElementById 'doc-content'

  loadMarkdown = (file) ->
    # Encode the file path for the URL to handle spaces
    encodedFile = encodeURI(file)
    console.log "Attempting to load Markdown file: /docs/#{encodedFile}"
    try
      response = await fetch "/docs/#{encodedFile}"
      console.log "Fetch response status: #{response.status}"
      throw new Error("Failed to load Markdown file: #{response.statusText}") unless response.ok
      markdown = await response.text()
      console.log "Markdown content received: #{markdown.substring(0, 100)}..." # Log first 100 chars
      html = marked.parse markdown,
        baseUrl: "/docs/#{encodedFile.substring(0, encodedFile.lastIndexOf('/'))}/"
        breaks: true
        gfm: true
      docContent.innerHTML = html
    catch error
      console.error 'Error loading Markdown:', error
      docContent.innerHTML = '<p class="text-red-500">Failed to load documentation. Error: ' + error.message + '</p>'

  # Load the first document by default or the active file if passed
  firstLink = document.querySelector '.doc-link'
  if firstLink
    console.log "First link found, loading: #{firstLink.dataset.mdFile}"
    loadMarkdown firstLink.dataset.mdFile
  else
    console.log "No doc-link found"
