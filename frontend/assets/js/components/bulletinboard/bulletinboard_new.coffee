# assets/js/components/bulletinboard/bulletinboard_new.coffee

BulletinBoardNew =
  init: ->
    @editor = document.getElementById('bulletin-editor')
    @titleInput = document.getElementById('bulletin-title')
    @wordCount = document.getElementById('bulletin-word-count')
    @statusBar = document.getElementById('bulletin-status')
    @submitBtn = document.getElementById('submit-bulletin')
    @previewBtn = document.getElementById('preview-bulletin')
    @previewContent = document.getElementById('preview-content')
    @previewSection = document.getElementById('bulletin-preview')
    @aiSuggestBtn = document.getElementById('ai-suggest-content')
    @csrfToken = document.querySelector('meta[name="csrf-token-bulletin"]')?.content or ''

    @setupEvents()

  setupEvents: ->
    @editor.addEventListener 'input', @updateWordCount.bind(@)
    document.getElementById('add-image-bulletin').addEventListener 'click', @addImage.bind(@)
    document.getElementById('add-video-bulletin').addEventListener 'click', @addVideo.bind(@)
    @submitBtn.addEventListener 'click', @submitBulletin.bind(@)
    @previewBtn.addEventListener 'click', @previewBulletin.bind(@)
    @aiSuggestBtn.addEventListener 'click', @suggestContent.bind(@)
    document.getElementById('bulletin-modal').addEventListener 'click', (e) =>
      if e.target == document.getElementById('bulletin-modal')
        document.getElementById('bulletin-modal').classList.add('hidden')

  updateWordCount: ->
    text = @editor.innerText.trim()
    words = if text then text.split(/\s+/).length else 0
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
          @editor.appendChild(img)
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
          @editor.appendChild(video)
        reader.readAsDataURL(file)
    fileInput.click()

  previewBulletin: ->
    @previewContent.innerHTML = @editor.innerHTML
    @previewSection.classList.remove('hidden')

  suggestContent: ->
    fetch '/api/ai/assist',
      method: 'POST'
      headers:
        'Content-Type': 'application/json'
        'X-CSRF-Token': @csrfToken
      body: JSON.stringify({ prompt: 'Suggest content for a bulletin post about ' + @titleInput.value })
    .then (response) => response.json()
    .then (data) =>
      @editor.innerHTML = data.suggestion

  submitBulletin: ->
    title = @titleInput.value
    content = @editor.innerHTML
    if title.trim() and content.trim()
      @statusBar.style.width = '0%'
      @statusBar.classList.remove('hidden')

      data =
        title: title
        content: content
        _token: @csrfToken

      fetch '/api/bulletin/create',
        method: 'POST'
        headers:
          'Content-Type': 'application/json'
          'Accept': 'application/json'
        body: JSON.stringify(data)
      .then (response) =>
        if response.ok
          response.json().then (json) =>
            @handleBulletinSuccess(json)
        else
          response.json().then (json) =>
            @statusBar.textContent = "Error: #{json.message or 'Failed to post'}"
            @statusBar.style.backgroundColor = '#e53e3e'
            setTimeout (=> @statusBar.classList.add('hidden')), 3000
      .catch (error) =>
        console.error 'Bulletin Error:', error
        @statusBar.textContent = 'Error: Network issue'
        @statusBar.style.backgroundColor = '#e53e3e'
        setTimeout (=> @statusBar.classList.add('hidden')), 3000

      animate = =>
        width = parseInt(@statusBar.style.width) or 0
        if width < 100
          width += 10
          @statusBar.style.width = "#{width}%"
          setTimeout(animate, 200)
      animate()
    else
      alert 'Please enter a title and content!'

  handleBulletinSuccess: (json) ->
    @statusBar.textContent = 'Your bulletin has been posted!'
    setTimeout =>
      @statusBar.innerHTML = "Would you like to see bulletin in <a href='#{json.feed_url}' class='text-white underline'>Global Feed</a> or <a href='#{json.user_url}' class='text-white underline'>User Page</a>?"
      countdown = =>
        count = 3
        interval = setInterval =>
          @statusBar.textContent = "This will close in #{count}..."
          count--
          if count < 0
            clearInterval(interval)
            document.getElementById('bulletin-modal').classList.add('hidden')
        , 1000
      countdown()
    , 1000

document.addEventListener 'DOMContentLoaded', ->
  BulletinBoardNew.init()
