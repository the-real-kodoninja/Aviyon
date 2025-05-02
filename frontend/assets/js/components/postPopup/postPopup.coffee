# assets/js/components/postPopup/postPopup.coffee

PostPopup =
  init: ->
    @editor = document.getElementById('post-content')
    @wordCount = document.getElementById('word-count')
    @statusBar = document.getElementById('post-status')
    @closeBtn = document.getElementById('close-post-popup')
    @submitBtn = document.getElementById('submit-post')
    @initialized = false

    # Fetch CSRF token
    @csrfToken = document.querySelector('meta[name="csrf-token-post"]')?.content or ''

    @setupEvents()

  setupEvents: ->
    @editor.addEventListener 'input', @updateWordCount.bind(@)
    document.getElementById('add-image').addEventListener 'click', @addImage.bind(@)
    document.getElementById('add-video').addEventListener 'click', @addVideo.bind(@)
    @submitBtn.addEventListener 'click', @submitPost.bind(@)
    @closeBtn.addEventListener 'click', @close.bind(@)

  updateWordCount: ->
    words = @editor.value.trim().split(/\s+/).length
    @wordCount.textContent = "#{words} words"

  addImage: ->
    fileInput = document.createElement('input')
    fileInput.type = 'file'
    fileInput.accept = 'image/*'
    fileInput.addEventListener 'change', (e) =>
      file = e.target.files[0]
      if file
        reader = new FileReader()
        reader.onload = (event) =>
          img = document.createElement('img')
          img.src = event.target.result
          img.className = 'w-full h-auto my-2 rounded-lg'
          @editor.insertAdjacentElement('beforebegin', img)
        reader.readAsDataURL(file)
    fileInput.click()

  addVideo: ->
    fileInput = document.createElement('input')
    fileInput.type = 'file'
    fileInput.accept = 'video/*'
    fileInput.addEventListener 'change', (e) =>
      file = e.target.files[0]
      if file
        reader = new FileReader()
        reader.onload = (event) =>
          video = document.createElement('video')
          video.controls = true
          video.className = 'w-full h-auto my-2 rounded-lg'
          source = document.createElement('source')
          source.src = event.target.result
          source.type = file.type
          video.appendChild(source)
          @editor.insertAdjacentElement('beforebegin', video)
        reader.readAsDataURL(file)
    fileInput.click()

  submitPost: ->
    content = @editor.value
    if content.trim()
      @statusBar.style.width = '0%'
      @statusBar.classList.remove('hidden')

      # Prepare the data for the API call
      data =
        content: content
        _token: @csrfToken

      # Make the API call
      fetch '/api/post/create',
        method: 'POST'
        headers:
          'Content-Type': 'application/json'
          'Accept': 'application/json'
        body: JSON.stringify(data)
      .then (response) =>
        if response.ok
          response.json().then (json) =>
            @handlePostSuccess(json)
        else
          response.json().then (json) =>
            @statusBar.textContent = "Error: #{json.message or 'Failed to post'}"
            @statusBar.style.backgroundColor = '#e53e3e'
            setTimeout (=> @statusBar.classList.add('hidden')), 3000
      .catch (error) =>
        console.error 'Post Error:', error
        @statusBar.textContent = 'Error: Network issue'
        @statusBar.style.backgroundColor = '#e53e3e'
        setTimeout (=> @statusBar.classList.add('hidden')), 3000

      # Simulate progress bar animation
      animate = =>
        width = parseInt(@statusBar.style.width) or 0
        if width < 100
          width += 10
          @statusBar.style.width = "#{width}%"
          setTimeout(animate, 200)
      animate()
    else
      alert 'Please enter some content!'

  handlePostSuccess: (json) ->
    @statusBar.textContent = 'Your post has been posted!'
    setTimeout =>
      @statusBar.innerHTML = "Would you like to see post in <a href='#{json.feed_url}' class='text-white underline'>Global Feed</a> or <a href='#{json.user_url}' class='text-white underline'>User Page</a>?"
      countdown = =>
        count = 3
        interval = setInterval =>
          @statusBar.textContent = "This will close in #{count}..."
          count--
          if count < 0
            clearInterval(interval)
            @close()
        , 1000
      countdown()
    , 1000

  open: ->
    popup = document.getElementById('post-popup')
    popup.classList.remove('hidden')
    popup.style.position = 'fixed'
    popup.style.top = '50%'
    popup.style.left = '50%'
    popup.style.transform = 'translate(-50%, -50%)'
    @init() if not @initialized
    @initialized = true

  close: ->
    document.getElementById('post-popup').classList.add('hidden')
    @editor.value = ''
    @wordCount.textContent = '0 words'
    @statusBar.classList.add('hidden')
    @statusBar.style.width = '0%'

document.addEventListener 'DOMContentLoaded', ->
  PostPopup.init()
