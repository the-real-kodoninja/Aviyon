# WYSIWYG Editor Functionality
document.addEventListener 'DOMContentLoaded', ->
  editor = document.getElementById('editor')
  titleInput = document.getElementById('article-title')

  # Bold
  document.getElementById('bold').addEventListener 'click', ->
    document.execCommand('bold', false, null)

  # Italic
  document.getElementById('italic').addEventListener 'click', ->
    document.execCommand('italic', false, null)

  # Underline
  document.getElementById('underline').addEventListener 'click', ->
    document.execCommand('underline', false, null)

  # Headings
  document.getElementById('heading').addEventListener 'change', (e) ->
    value = e.target.value
    if value
      document.execCommand('formatBlock', false, value)
    else
      document.execCommand('formatBlock', false, 'p')

  # Add Image
  document.getElementById('add-image').addEventListener 'click', ->
    fileInput = document.createElement('input')
    fileInput.type = 'file'
    fileInput.accept = 'image/*'
    fileInput.addEventListener 'change', (e) ->
      file = e.target.files[0]
      if file
        reader = new FileReader()
        reader.onload = (event) ->
          img = document.createElement('img')
          img.src = event.target.result
          img.className = 'w-full h-auto my-2 rounded-lg'
          editor.appendChild(img)
        reader.readAsDataURL(file)
    fileInput.click()

  # Add Video
  document.getElementById('add-video').addEventListener 'click', ->
    fileInput = document.createElement('input')
    fileInput.type = 'file'
    fileInput.accept = 'video/*'
    fileInput.addEventListener 'change', (e) ->
      file = e.target.files[0]
      if file
        reader = new FileReader()
        reader.onload = (event) ->
          video = document.createElement('video')
          video.controls = true
          video.className = 'w-full h-auto my-2 rounded-lg'
          source = document.createElement('source')
          source.src = event.target.result
          source.type = file.type
          video.appendChild(source)
          editor.appendChild(video)
        reader.readAsDataURL(file)
    fileInput.click()

  # Add YouTube Video
  document.getElementById('add-youtube').addEventListener 'click', ->
    url = prompt('Enter YouTube video URL:')
    if url
      videoId = url.match(/(?:https?:\/\/)?(?:www\.)?youtube\.com\/watch\?v=([^&]+)/)?.[1] or url.match(/(?:https?:\/\/)?youtu\.be\/([^?]+)/)?.[1]
      if videoId
        iframe = document.createElement('iframe')
        iframe.src = "https://www.youtube.com/embed/#{videoId}"
        iframe.className = 'w-full h-64 my-2 rounded-lg'
        iframe.frameBorder = '0'
        iframe.allowFullscreen = true
        editor.appendChild(iframe)

  # Save Article
  document.getElementById('save-article').addEventListener 'click', ->
    title = titleInput.value
    content = editor.innerHTML
    # Placeholder for saving logic (e.g., send to server via AJAX)
    alert("Saving article: #{title}")
    console.log(content: content)
