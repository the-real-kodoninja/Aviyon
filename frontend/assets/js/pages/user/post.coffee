document.addEventListener 'DOMContentLoaded', ->
  input = document.getElementById 'post-input'
  photoInput = document.getElementById 'post-photo'
  videoInput = document.getElementById 'post-video'
  submitBtn = document.getElementById 'post-submit'
  preview = document.getElementById 'post-preview'
  previewText = document.getElementById 'preview-text'
  previewPhoto = document.getElementById 'preview-photo'
  previewVideo = document.getElementById 'preview-video'
  previewLink = document.getElementById 'preview-link'
  newPostContainer = document.getElementById 'new-post-container'
  emojiPopup = document.getElementById 'emoji-popup'
  emojiContent = document.getElementById 'emoji-content'
  gifPopup = document.getElementById 'gif-popup'
  gifContent = document.getElementById 'gif-content'
  infoTooltip = document.getElementById 'info-tooltip'

  # Expand textarea on focus
  input.addEventListener 'focus', ->
    input.rows = 3
  input.addEventListener 'blur', ->
    input.rows = 1 if input.value == ''

  # Photo and Video Preview
  photoInput.addEventListener 'change', (e) ->
    file = e.target.files[0]
    if file
      previewPhoto.src = URL.createObjectURL(file)
      previewPhoto.classList.remove 'hidden'
      preview.classList.remove 'hidden'

  videoInput.addEventListener 'change', (e) ->
    file = e.target.files[0]
    if file
      previewVideo.querySelector('source').src = URL.createObjectURL(file)
      previewVideo.load()
      previewVideo.classList.remove 'hidden'
      preview.classList.remove 'hidden'

  # Info Tooltip
  document.getElementById('post-info').addEventListener 'mouseover', ->
    infoTooltip.classList.remove 'hidden'
  document.getElementById('post-info').addEventListener 'mouseout', ->
    infoTooltip.classList.add 'hidden'

  # Emoji Popup
  document.getElementById('post-emoji').addEventListener 'click', ->
    emojiContent.innerHTML = ''
    emojis = ['😀', '😂', '❤️', '👍', '😎', '🎉', '🚀', '🌌']
    for emoji in emojis
      span = document.createElement 'span'
      span.textContent = emoji
      span.className = 'cursor-pointer hover:bg-gray-700 p-2 rounded'
      span.addEventListener 'click', ->
        input.value += emoji
        emojiPopup.classList.add 'hidden'
      emojiContent.appendChild span
    emojiPopup.classList.remove 'hidden'

  document.getElementById('close-emoji').addEventListener 'click', ->
    emojiPopup.classList.add 'hidden'

  # GIF Popup (Mock with placeholders)
  document.getElementById('post-gif').addEventListener 'click', ->
    gifContent.innerHTML = ''
    for i in [1..8]
      img = document.createElement 'img'
      img.src = "https://via.placeholder.com/100?text=GIF+#{i}"
      img.className = 'cursor-pointer hover:shadow-lg rounded'
      img.addEventListener 'click', ->
        input.value += img.src
        gifPopup.classList.add 'hidden'
      gifContent.appendChild img
    gifPopup.classList.remove 'hidden'

  document.getElementById('close-gif').addEventListener 'click', ->
    gifPopup.classList.add 'hidden'

  # URL Handling (YouTube and General Links)
  input.addEventListener 'input', (e) ->
    text = e.target.value
    urlMatch = text.match(/(https?:\/\/[^\s]+)/g)
    if urlMatch
      url = urlMatch[0]
      if url.includes('youtube.com')
        videoId = url.split('v=')[1]?.split('&')[0]
        previewLink.innerHTML = "<iframe src='https://www.youtube.com/embed/#{videoId}' class='w-full h-48 rounded-lg mt-2' frameborder='0'></iframe>"
      else
        previewLink.innerHTML = "<div class='bg-gray-600 p-4 rounded-lg mt-2'><a href='#{url}' class='text-purple-400 hover:underline'>#{url}</a></div>"
      previewLink.classList.remove 'hidden'
      preview.classList.remove 'hidden'
    else
      previewLink.classList.add 'hidden'

  # Submit Post
  submitBtn.addEventListener 'click', ->
    text = input.value
    if text or previewPhoto.src or previewVideo.src or previewLink.innerHTML
      newPost = document.createElement 'div'
      newPost.className = 'bg-gray-800 p-6 rounded-xl shadow-lg mb-6 neon-glow'
      newPost.innerHTML = """
        <div class="flex items-center mb-4">
          <img src="{{ asset('build/images/users/' ~ user.username ~ '.png') }}" alt="{{ user.username }} Avatar" class="w-8 h-8 rounded-full mr-2">
          <div>
            <p class="text-sm text-purple-400">{{ user.username }}</p>
            <p class="text-xs text-gray-400">Just now</p>
          </div>
        </div>
        <p class="text-gray-300 mb-4">#{text}</p>
        #{if previewPhoto.src and !previewPhoto.classList.contains('hidden') then "<img src='#{previewPhoto.src}' class='w-full max-h-48 rounded-lg mb-4'>" else ''}
        #{if previewVideo.src and !previewVideo.classList.contains('hidden') then "<video controls class='w-full max-h-48 rounded-lg mb-4'><source src='#{previewVideo.querySelector('source').src}' type='video/mp4'></video>" else ''}
        #{if previewLink.innerHTML and !previewLink.classList.contains('hidden') then previewLink.innerHTML else ''}
        <div class="flex space-x-4 text-gray-400">
          <div class="flex items-center"><svg class="w-5 h-5 mr-1" fill="currentColor" viewBox="0 0 24 24"><path d="M12 21.35l-1.45-1.32C5.4 15.36 2 12.28 2 8.5 2 5.42 4.42 3 7.5 3c1.74 0 3.41.81 4.5 2.09C13.09 3.81 14.76 3 16.5 3 19.58 3 22 5.42 22 8.5c0 3.78-3.4 6.86-8.55 11.54L12 21.35z"/></svg><span>0</span></div>
          <div class="flex items-center"><svg class="w-5 h-5 mr-1" fill="currentColor" viewBox="0 0 24 24"><path d="M18 16.08c-.76 0-1.44.3-1.96.77L8.91 12.7c.05-.23.09-.46.09-.7s-.04-.47-.09-.70l7.05-4.11c.54.5 1.25.81 2.04.81 1.66 0 3-1.34 3-3s-1.34-3-3-3-3 1.34-3 3c0 .24.04.47.09.70L8.04 9.81C7.5 9.31 6.79 9 6 9c-1.66 0-3 1.34-3 3s1.34 3 3 3c.79 0 1.5-.31 2.04-.81l7.12 4.16c-.05.21-.08.43-.08.65 0 1.61 1.31 2.92 2.92 2.92s2.92-1.31 2.92-2.92c0-1.61-1.31-2.92-2.92-2.92zM18 4c.55 0 1 .45 1 1s-.45 1-1 1-1-.45-1-1 .45-1 1-1zM6 13c-.55 0-1-.45-1-1s.45-1 1-1 1 .45 1 1-.45 1-1 1zm12 7.02c-.55 0-1-.45-1-1s.45-1 1-1 1 .45 1 1-.45 1-1 1z"/></svg><span>0</span></div>
        </div>
      """
      newPostContainer.insertBefore newPost, newPostContainer.firstChild
      input.value = ''
      input.rows = 1
      previewPhoto.classList.add 'hidden'
      previewVideo.classList.add 'hidden'
      previewLink.classList.add 'hidden'
      preview.classList.add 'hidden'
