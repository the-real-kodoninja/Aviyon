document.addEventListener 'DOMContentLoaded', ->
  input = document.getElementById 'post-input'
  photoInput = document.getElementById 'post-photo'
  videoInput = document.getElementById 'post-video'
  documentInput = document.getElementById 'post-document'
  submitBtn = document.getElementById 'post-submit'
  preview = document.getElementById 'post-preview'
  previewText = document.getElementById 'preview-text'
  previewPhoto = document.getElementById 'preview-photo'
  previewVideo = document.getElementById 'preview-video'
  previewDocument = document.getElementById 'preview-document'
  previewPoll = document.getElementById 'preview-poll'
  previewSchedule = document.getElementById 'preview-schedule'
  newPostContainer = document.getElementById 'new-post-container'
  emojiPopup = document.getElementById 'emoji-popup'
  emojiContent = document.getElementById 'emoji-content'
  gifPopup = document.getElementById 'gif-popup'
  gifContent = document.getElementById 'gif-content'
  gifSearch = document.getElementById 'gif-search'
  pollPopup = document.getElementById 'poll-popup'
  pollForm = document.getElementById 'poll-form'
  pollQuestion = document.getElementById 'poll-question'
  pollOptions = document.getElementById 'poll-options'
  addPollOption = document.getElementById 'add-poll-option'
  submitPoll = document.getElementById 'submit-poll'
  schedulePopup = document.getElementById 'schedule-popup'
  scheduleTime = document.getElementById 'schedule-time'
  submitSchedule = document.getElementById 'submit-schedule'
  analyticsOverlay = document.getElementById 'analytics-overlay'
  settingsBtn = document.getElementById 'settings-btn'
  settingsMenu = document.getElementById 'settings-menu'
  pinPostBtn = document.getElementById 'pin-post'
  editPostBtn = document.getElementById 'edit-post'
  deletePostBtn = document.getElementById 'delete-post'
  reportPostBtn = document.getElementById 'report-post'
  muteUserBtn = document.getElementById 'mute-user'
  pinnedLabel = document.getElementById 'pinned-label'
  viewComments = document.getElementById 'view-comments'
  commentCount = document.getElementById 'comment-count'
  commentsSection = document.getElementById 'comments-section'
  newComment = document.getElementById 'new-comment'
  commentPhoto = document.getElementById 'comment-photo'
  commentDocument = document.getElementById 'comment-document'
  commentEmoji = document.getElementById 'comment-emoji'
  commentGif = document.getElementById 'comment-gif'
  submitComment = document.getElementById 'submit-comment'
  commentPreview = document.getElementById 'comment-preview'
  commentPreviewPhoto = document.getElementById 'comment-preview-photo'
  commentPreviewDocument = document.getElementById 'comment-preview-document'
  commentsList = document.getElementById 'comments-list'
  viewMoreComments = document.getElementById 'view-more-comments'
  liveReactions = document.getElementById 'live-reactions'
  toggleAnalytics = document.getElementById 'toggle-analytics'

  # Expand textarea on focus
  input.addEventListener 'focus', ->
    input.rows = 3
  input.addEventListener 'blur', ->
    input.rows = 1 if input.value.trim() == ''

  # Word Count
  input.addEventListener 'input', ->
    words = input.value.trim().split(/\s+/).length
    remaining = 280 - words
    if remaining <= 0
      input.value = input.value.split(/\s+/).slice(0, 280).join(' ')
    previewText.textContent = input.value || 'Preview your post here...'

  # Photo, Video, and Document Preview
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

  documentInput.addEventListener 'change', (e) ->
    file = e.target.files[0]
    if file
      previewDocument.innerHTML = "<p class='text-gray-300'>#{file.name}</p>"
      previewDocument.classList.remove 'hidden'
      preview.classList.remove 'hidden'

  # Emoji Popup
  document.getElementById('post-emoji').addEventListener 'click', ->
    emojiContent.innerHTML = ''
    emojis = ['😀', '😂', '❤️', '👍', '😎', '🎉', '🚀', '🌌', '😍', '🤓']
    for emoji in emojis
      span = document.createElement 'span'
      span.textContent = emoji
      span.className = 'cursor-pointer hover:bg-gray-700 p-2 rounded transition'
      span.addEventListener 'click', ->
        input.value += emoji
        previewText.textContent = input.value
        emojiPopup.classList.add 'hidden'
      emojiContent.appendChild span
    emojiPopup.classList.remove 'hidden'

  document.getElementById('close-emoji').addEventListener 'click', ->
    emojiPopup.classList.add 'hidden'

  # GIF Popup with Search
  document.getElementById('post-gif').addEventListener 'click', ->
    gifContent.innerHTML = ''
    for i in [1..12]
      img = document.createElement 'img'
      img.src = "https://via.placeholder.com/100?text=GIF+#{i}"
      img.className = 'cursor-pointer hover:shadow-lg rounded transition'
      img.addEventListener 'click', ->
        input.value += img.src
        previewText.textContent = input.value
        gifPopup.classList.add 'hidden'
      gifContent.appendChild img
    gifPopup.classList.remove 'hidden'

  gifSearch.addEventListener 'input', (e) ->
    query = e.target.value
    gifContent.innerHTML = ''
    for i in [1..12]
      img = document.createElement 'img'
      img.src = "https://via.placeholder.com/100?text=#{query}+GIF+#{i}"
      img.className = 'cursor-pointer hover:shadow-lg rounded transition'
      img.addEventListener 'click', ->
        input.value += img.src
        previewText.textContent = input.value
        gifPopup.classList.add 'hidden'
      gifContent.appendChild img

  document.getElementById('close-gif').addEventListener 'click', ->
    gifPopup.classList.add 'hidden'

  # Poll Popup
  document.getElementById('post-poll').addEventListener 'click', ->
    pollPopup.classList.remove 'hidden'

  addPollOption.addEventListener 'click', ->
    input = document.createElement 'input'
    input.className = 'w-full bg-gray-800 text-gray-300 p-2 rounded mt-2'
    input.placeholder = "Option #{pollOptions.children.length + 1}"
    pollOptions.appendChild input

  submitPoll.addEventListener 'click', ->
    question = pollQuestion.value
    options = Array.from(pollOptions.querySelectorAll('input')).map((input) -> input.value).filter((val) -> val)
    if question and options.length >= 2
      previewPoll.innerHTML = """
        <div class="bg-gray-700 p-4 rounded-lg">
          <p class="text-gray-300">#{question}</p>
          #{options.map((opt, idx) -> "<div class='flex items-center'><input type='radio' name='poll' class='mr-2'><span>#{opt}</span></div>").join('')}
        </div>
      """
      previewPoll.classList.remove 'hidden'
      preview.classList.remove 'hidden'
      pollPopup.classList.add 'hidden'
      pollQuestion.value = ''
      pollOptions.innerHTML = "<input class='w-full bg-gray-800 text-gray-300 p-2 rounded' placeholder='Option 1'><input class='w-full bg-gray-800 text-gray-300 p-2 rounded' placeholder='Option 2'>"

  document.getElementById('close-poll').addEventListener 'click', ->
    pollPopup.classList.add 'hidden'

  # Schedule Popup
  document.getElementById('post-schedule').addEventListener 'click', ->
    schedulePopup.classList.remove 'hidden'

  submitSchedule.addEventListener 'click', ->
    time = scheduleTime.value
    if time
      previewSchedule.innerHTML = "<p class='text-gray-300'>Scheduled for: #{new Date(time).toLocaleString()}</p>"
      previewSchedule.classList.remove 'hidden'
      preview.classList.remove 'hidden'
      schedulePopup.classList.add 'hidden'

  document.getElementById('close-schedule').addEventListener 'click', ->
    schedulePopup.classList.add 'hidden'

  # Settings Menu
  settingsBtn.addEventListener 'click', ->
    settingsMenu.classList.toggle 'hidden'

  pinPostBtn.addEventListener 'click', ->
    pinnedLabel.classList.toggle 'hidden'
    settingsMenu.classList.add 'hidden'
    if not pinnedLabel.classList.contains('hidden')
      pinnedLabel.classList.add 'animate-pulse-once'

  editPostBtn.addEventListener 'click', ->
    input.value = previewText.textContent
    preview.classList.add 'hidden'
    settingsMenu.classList.add 'hidden'

  deletePostBtn.addEventListener 'click', ->
    postContainer.remove()
    settingsMenu.classList.add 'hidden'

  reportPostBtn.addEventListener 'click', ->
    alert 'Post reported to moderators!'
    settingsMenu.classList.add 'hidden'

  muteUserBtn.addEventListener 'click', ->
    alert 'User muted successfully!'
    settingsMenu.classList.add 'hidden'

  # Submit Post
  submitBtn.addEventListener 'click', ->
    text = input.value.trim()
    if text or previewPhoto.src or previewVideo.src or previewDocument.innerHTML or previewPoll.innerHTML or previewSchedule.innerHTML
      newPost = document.createElement 'div'
      newPost.className = 'bg-gray-800 p-6 rounded-xl shadow-lg mb-6 neon-glow relative group'
      newPost.innerHTML = """
        <div class="absolute top-4 left-4 bg-purple-600 text-white text-xs font-bold px-2 py-1 rounded #{if pinnedLabel.classList.contains('hidden') then 'hidden' else 'animate-pulse-once'}">Pinned</div>
        <div class="absolute top-4 right-4">
          <button class="text-gray-400 hover:text-purple-400 focus:outline-none">
            <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 24 24">
              <path d="M12 8c-2.21 0-4 1.79-4 4s1.79 4 4 4 4-1.79 4-4-1.79-4-4-4zm0 6c-1.1 0-2-.9-2-2s.9-2 2-2 2 .9 2 2-.9 2-2 2zm9-2c0-.55-.45-1-1-1h-2.07c-.27-1.01-.71-1.96-1.27-2.83l1.47-1.47c.39-.39.39-1.02 0-1.41-.39-.39-1.02-.39-1.41 0l-1.47 1.47c-.87-.56-1.82-1-2.83-1.27V4c0-.55-.45-1-1-1s-1 .45-1 1v1.07c-1.01.27-1.96.71-2.83 1.27L5.41 4.87c-.39-.39-1.02-.39-1.41 0-.39.39-.39 1.02 0 1.41L5.47 7.74c-.56.87-1 .82-1.27 2.83H4c-.55 0-1 .45-1 1s.45 1 1 1h2.07c.27 1.01.71 1.96 1.27 2.83L4.87 18.59c-.39.39-.39 1.02 0 1.41.39.39 1.02.39 1.41 0l1.47-1.47c.87.56 1.82 1 2.83 1.27V20c0 .55.45 1 1 1s1-.45 1-1v-1.07c1.01-.27 1.96-.71 2.83-1.27l1.47 1.47c.39.39 1.02.39 1.41 0 .39-.39.39-1.02 0-1.41l-1.47-1.47c.56-.87 1-.82 1.27-2.83H20c.55 0 1-.45 1-1z"/>
            </svg>
          </button>
        </div>
        <div class="flex items-center mb-4">
          <img src="{{ asset('build/images/users/' ~ user.username ~ '.png') }}" alt="{{ user.username }} Avatar" class="w-8 h-8 rounded-full mr-2 transition-transform group-hover:scale-105">
          <div>
            <p class="text-sm text-purple-400">{{ user.username }}</p>
            <p class="text-xs text-gray-400">Just now</p>
          </div>
        </div>
        <div id="post-content-display" class="text-gray-300 mb-4">#{text}</div>
        #{if previewPhoto.src and !previewPhoto.classList.contains('hidden') then "<img src='#{previewPhoto.src}' class='w-full max-h-48 rounded-lg mb-4 transition-opacity opacity-100 hover:opacity-90'>" else ''}
        #{if previewVideo.src and !previewVideo.classList.contains('hidden') then "<video controls class='w-full max-h-48 rounded-lg mb-4 transition-opacity opacity-100 hover:opacity-90'><source src='#{previewVideo.querySelector('source').src}' type='video/mp4'></video>" else ''}
        #{if previewDocument.innerHTML and !previewDocument.classList.contains('hidden') then "<div class='bg-gray-700 p-2 rounded-lg mb-4'>#{previewDocument.innerHTML}</div>" else ''}
        #{if previewPoll.innerHTML and !previewPoll.classList.contains('hidden') then "#{previewPoll.innerHTML}" else ''}
        #{if previewSchedule.innerHTML and !previewSchedule.classList.contains('hidden') then "<div class='bg-gray-700 p-2 rounded-lg mb-4'>#{previewSchedule.innerHTML}</div>" else ''}
        <div class="flex justify-between items-center">
          <div class="flex space-x-4 text-gray-400">
            <div class="flex items-center relative group/reaction">
              <svg class="w-5 h-5 mr-1 cursor-pointer hover:text-red-400 transition" fill="currentColor" viewBox="0 0 24 24">
                <path d="M12 21.35l-1.45-1.32C5.4 15.36 2 12.28 2 8.5 2 5.42 4.42 3 7.5 3c1.74 0 3.41.81 4.5 2.09C13.09 3.81 14.76 3 16.5 3 19.58 3 22 5.42 22 8.5c0 3.78-3.4 6.86-8.55 11.54L12 21.35z"/>
              </svg>
              <span id="like-count">0</span>
              <div class="absolute bottom-full left-1/2 transform -translate-x-1/2 mb-2 hidden group-hover/reaction:block bg-gray-800 text-white text-sm p-2 rounded-lg">
                <button class="block w-full text-center hover:bg-gray-700 py-1">👍 Like</button>
                <button class="block w-full text-center hover:bg-gray-700 py-1">❤️ Love</button>
                <button class="block w-full text-center hover:bg-gray-700 py-1">😂 Haha</button>
              </div>
            </div>
            <div class="flex items-center">
              <svg class="w-5 h-5 mr-1 cursor-pointer hover:text-purple-400 transition" fill="currentColor" viewBox="0 0 24 24">
                <path d="M20 2H4c-1.1 0-2 .9-2 2v18l4-4h14c1.1 0 2-.9 2-2V4c0-1.1-.9-2-2-2zm0 14H6l-2 2V4h16v12z"/>
              </svg>
              <span id="comment-count-static">0</span>
            </div>
            <div class="flex items-center">
              <svg class="w-5 h-5 mr-1 cursor-pointer hover:text-green-400 transition" fill="currentColor" viewBox="0 0 24 24">
                <path d="M18 16.08c-.76 0-1.44.3-1.96.77L8.91 12.7c.05-.23.09-.46.09-.7s-.04-.47-.09-.7l7.05-4.11c.54.5 1.25.81 2.04.81 1.66 0 3-1.34 3-3s-1.34-3-3-3-3 1.34-3 3c0 .24.04.47.09.7L8.04 9.81C7.5 9.31 6.79 9 6 9c-1.66 0-3 1.34-3 3s1.34 3 3 3c.79 0 1.5-.31 2.04-.81l7.12 4.16c-.05.21-.08.43-.08.65 0 1.61 1.31 2.92 2.92 2.92s2.92-1.31 2.92-2.92c0-1.61-1.31-2.92-2.92-2.92zM6 13c-.55 0-1-.45-1-1s.45-1 1-1 1 .45 1 1-.45 1-1 1zm12 7.02c-.55 0-1-.45-1-1s.45-1 1-1 1 .45 1 1-.45 1-1 1z"/>
              </svg>
              <span>0</span>
            </div>
          </div>
          <div class="flex space-x-2">
            <span id="post-age" class="text-gray-500 text-xs">Just now</span>
          </div>
        </div>
      """
      newPostContainer.insertBefore newPost, newPostContainer.firstChild
      input.value = ''
      input.rows = 1
      previewPhoto.classList.add 'hidden'
      previewVideo.classList.add 'hidden'
      previewDocument.classList.add 'hidden'
      previewPoll.classList.add 'hidden'
      previewSchedule.classList.add 'hidden'
      preview.classList.add 'hidden'

  # View Comments
  viewComments.addEventListener 'click', (e) ->
    e.preventDefault()
    commentsSection.classList.toggle 'hidden'
    if not commentsSection.classList.contains 'hidden'
      loadComments()

  # Comment Photo and Document Preview
  commentPhoto.addEventListener 'change', (e) ->
    file = e.target.files[0]
    if file
      commentPreviewPhoto.src = URL.createObjectURL(file)
      commentPreviewPhoto.classList.remove 'hidden'
      commentPreview.classList.remove 'hidden'

  commentDocument.addEventListener 'change', (e) ->
    file = e.target.files[0]
    if file
      commentPreviewDocument.innerHTML = "<p class='text-gray-300'>#{file.name}</p>"
      commentPreviewDocument.classList.remove 'hidden'
      commentPreview.classList.remove 'hidden'

  # Comment Emoji Popup
  commentEmoji.addEventListener 'click', ->
    emojiContent.innerHTML = ''
    emojis = ['😀', '😂', '❤️', '👍', '😎', '🎉', '🚀', '🌌', '😍', '🤓']
    for emoji in emojis
      span = document.createElement 'span'
      span.textContent = emoji
      span.className = 'cursor-pointer hover:bg-gray-700 p-2 rounded transition'
      span.addEventListener 'click', ->
        newComment.value += emoji
        emojiPopup.classList.add 'hidden'
      emojiContent.appendChild span
    emojiPopup.classList.remove 'hidden'

  # Comment GIF Popup
  commentGif.addEventListener 'click', ->
    gifContent.innerHTML = ''
    for i in [1..12]
      img = document.createElement 'img'
      img.src = "https://via.placeholder.com/100?text=GIF+#{i}"
      img.className = 'cursor-pointer hover:shadow-lg rounded transition'
      img.addEventListener 'click', ->
        newComment.value += img.src
        gifPopup.classList.add 'hidden'
      gifContent.appendChild img
    gifPopup.classList.remove 'hidden'

  # Submit Comment
  submitComment.addEventListener 'click', ->
    text = newComment.value.trim()
    if text or commentPreviewPhoto.src or commentPreviewDocument.innerHTML
      newCommentDiv = document.createElement 'div'
      newCommentDiv.className = 'flex items-start mb-4'
      newCommentDiv.innerHTML = """
        <img src="{{ asset('build/images/users/' ~ user.username ~ '.png') }}" alt="{{ user.username }} Avatar" class="w-8 h-8 rounded-full mr-2">
        <div class="flex-1">
          <div class="bg-gray-700 p-3 rounded-lg">
            <p class="text-sm text-purple-400">{{ user.username }}</p>
            <p class="text-gray-300">#{text}</p>
            #{if commentPreviewPhoto.src and !commentPreviewPhoto.classList.contains('hidden') then "<img src='#{commentPreviewPhoto.src}' class='mt-2 max-h-48 rounded-lg'>" else ''}
            #{if commentPreviewDocument.innerHTML and !commentPreviewDocument.classList.contains('hidden') then "<div class='mt-2 bg-gray-600 p-2 rounded-lg'>#{commentPreviewDocument.innerHTML}</div>" else ''}
          </div>
          <div class="flex space-x-4 text-gray-400 mt-2">
            <button class="reply-btn text-xs hover:text-purple-400 transition">Reply</button>
            <div class="flex items-center">
              <svg class="w-4 h-4 mr-1 cursor-pointer hover:text-red-400 transition" fill="currentColor" viewBox="0 0 24 24">
                <path d="M12 21.35l-1.45-1.32C5.4 15.36 2 12.28 2 8.5 2 5.42 4.42 3 7.5 3c1.74 0 3.41.81 4.5 2.09C13.09 3.81 14.76 3 16.5 3 19.58 3 22 5.42 22 8.5c0 3.78-3.4 6.86-8.55 11.54L12 21.35z"/>
              </svg>
              <span class="text-xs">0</span>
            </div>
          </div>
          <div class="ml-10 mt-2 space-y-2 hidden reply-section"></div>
        </div>
      """
      commentsList.insertBefore newCommentDiv, commentsList.firstChild
      commentCount.textContent = parseInt(commentCount.textContent) + 1
      document.getElementById('comment-count-static').textContent = commentCount.textContent
      newComment.value = ''
      commentPreviewPhoto.classList.add 'hidden'
      commentPreviewDocument.classList.add 'hidden'
      commentPreview.classList.add 'hidden'
      if commentsList.children.length > 5
        viewMoreComments.classList.remove 'hidden'
      checkCommentVisibility()

      # Add Reply Functionality
      replyBtn = newCommentDiv.querySelector '.reply-btn'
      replySection = newCommentDiv.querySelector '.reply-section'
      replyBtn.addEventListener 'click', ->
        replySection.classList.toggle 'hidden'
        if not replySection.querySelector('textarea')
          replyInput = document.createElement 'textarea'
          replyInput.className = 'w-full bg-gray-700 text-gray-300 p-3 rounded-lg focus:outline-none focus:ring-2 focus:ring-purple-400 resize-none'
          replyInput.rows = 1
          replyInput.placeholder = 'Add a reply...'
          replyPhoto = document.createElement 'input'
          replyPhoto.type = 'file'
          replyPhoto.accept = 'image/*'
          replyPhoto.className = 'hidden'
          replyDocument = document.createElement 'input'
          replyDocument.type = 'file'
          replyDocument.accept = '.pdf,.doc,.docx'
          replyDocument.className = 'hidden'
          replyEmoji = document.createElement 'button'
          replyEmoji.className = 'flex items-center text-gray-400 hover:text-purple-400'
          replyEmoji.innerHTML = '<svg class="w-5 h-5 mr-1" fill="currentColor" viewBox="0 0 24 24"><path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm0 18c-4.41 0-8-3.59-8-8s3.59-8 8-8 8 3.59 8 8-3.59 8-8 8zm-1-13h2v2h-2zm0 4h2v6h-2zm1-9c-5.52 0-10 4.48-10 10s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2z"/></svg>'
          replySubmit = document.createElement 'button'
          replySubmit.className = 'bg-purple-600 text-white px-4 py-1 rounded-lg hover:bg-purple-700 transition mt-2'
          replySubmit.textContent = 'Reply'
          replySection.appendChild replyInput
          replySection.appendChild replyPhoto
          replySection.appendChild replyDocument
          replySection.appendChild replyEmoji
          replySection.appendChild replySubmit

          replyPhoto.addEventListener 'change', (e) ->
            file = e.target.files[0]
            if file
              img = document.createElement 'img'
              img.src = URL.createObjectURL(file)
              img.className = 'mt-2 max-h-48 rounded-lg'
              replySection.appendChild img

          replyDocument.addEventListener 'change', (e) ->
            file = e.target.files[0]
            if file
              div = document.createElement 'div'
              div.className = 'mt-2 bg-gray-600 p-2 rounded-lg'
              div.innerHTML = "<p class='text-gray-300'>#{file.name}</p>"
              replySection.appendChild div

          replyEmoji.addEventListener 'click', ->
            emojiContent.innerHTML = ''
            emojis = ['😀', '😂', '❤️', '👍', '😎']
            for emoji in emojis
              span = document.createElement 'span'
              span.textContent = emoji
              span.className = 'cursor-pointer hover:bg-gray-700 p-2 rounded transition'
              span.addEventListener 'click', ->
                replyInput.value += emoji
                emojiPopup.classList.add 'hidden'
              emojiContent.appendChild span
            emojiPopup.classList.remove 'hidden'

          replySubmit.addEventListener 'click', ->
            if replyInput.value.trim() or replySection.querySelector('img') or replySection.querySelector('.bg-gray-600')
              replyDiv = document.createElement 'div'
              replyDiv.className = 'flex items-start mt-2'
              replyDiv.innerHTML = """
                <img src="{{ asset('build/images/users/' ~ user.username ~ '.png') }}" alt="{{ user.username }} Avatar" class="w-6 h-6 rounded-full mr-2">
                <div class="bg-gray-700 p-3 rounded-lg">
                  <p class="text-sm text-purple-400">{{ user.username }}</p>
                  <p class="text-gray-300">#{replyInput.value}</p>
                  #{if replySection.querySelector('img') then "<img src='#{replySection.querySelector('img').src}' class='mt-2 max-h-48 rounded-lg'>" else ''}
                  #{if replySection.querySelector('.bg-gray-600') then "<div class='mt-2'>#{replySection.querySelector('.bg-gray-600').innerHTML}</div>" else ''}
                </div>
              """
              replySection.insertBefore replyDiv, replySection.querySelector('textarea')
              replyInput.value = ''
              replySection.querySelector('img')?.remove() if replySection.querySelector('img')
              replySection.querySelector('.bg-gray-600')?.remove() if replySection.querySelector('.bg-gray-600')
            emojiPopup.classList.add 'hidden'

      # Existing Reply Buttons
      for replyBtn in document.querySelectorAll '.reply-btn'
        replySection = replyBtn.parentElement.querySelector '.reply-section'
        replyBtn.addEventListener 'click', ->
          replySection.classList.toggle 'hidden'
          if not replySection.querySelector('textarea')
            replyInput = document.createElement 'textarea'
            replyInput.className = 'w-full bg-gray-700 text-gray-300 p-3 rounded-lg focus:outline-none focus:ring-2 focus:ring-purple-400 resize-none'
            replyInput.rows = 1
            replyInput.placeholder = 'Add a reply...'
            replyPhoto = document.createElement 'input'
            replyPhoto.type = 'file'
            replyPhoto.accept = 'image/*'
            replyPhoto.className = 'hidden'
            replyDocument = document.createElement 'input'
            replyDocument.type = 'file'
            replyDocument.accept = '.pdf,.doc,.docx'
            replyDocument.className = 'hidden'
            replyEmoji = document.createElement 'button'
            replyEmoji.className = 'flex items-center text-gray-400 hover:text-purple-400'
            replyEmoji.innerHTML = '<svg class="w-5 h-5 mr-1" fill="currentColor" viewBox="0 0 24 24"><path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm0 18c-4.41 0-8-3.59-8-8s3.59-8 8-8 8 3.59 8 8-3.59 8-8 8zm-1-13h2v2h-2zm0 4h2v6h-2zm1-9c-5.52 0-10 4.48-10 10s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2z"/></svg>'
            replySubmit = document.createElement 'button'
            replySubmit.className = 'bg-purple-600 text-white px-4 py-1 rounded-lg hover:bg-purple-700 transition mt-2'
            replySubmit.textContent = 'Reply'
            replySection.appendChild replyInput
            replySection.appendChild replyPhoto
            replySection.appendChild replyDocument
            replySection.appendChild replyEmoji
            replySection.appendChild replySubmit

            replyPhoto.addEventListener 'change', (e) ->
              file = e.target.files[0]
              if file
                img = document.createElement 'img'
                img.src = URL.createObjectURL(file)
                img.className = 'mt-2 max-h-48 rounded-lg'
                replySection.appendChild img

            replyDocument.addEventListener 'change', (e) ->
              file = e.target.files[0]
              if file
                div = document.createElement 'div'
                div.className = 'mt-2 bg-gray-600 p-2 rounded-lg'
                div.innerHTML = "<p class='text-gray-300'>#{file.name}</p>"
                replySection.appendChild div

            replyEmoji.addEventListener 'click', ->
              emojiContent.innerHTML = ''
              emojis = ['😀', '😂', '❤️', '👍', '😎']
              for emoji in emojis
                span = document.createElement 'span'
                span.textContent = emoji
                span.className = 'cursor-pointer hover:bg-gray-700 p-2 rounded transition'
                span.addEventListener 'click', ->
                  replyInput.value += emoji
                  emojiPopup.classList.add 'hidden'
                emojiContent.appendChild span
              emojiPopup.classList.remove 'hidden'

            replySubmit.addEventListener 'click', ->
              if replyInput.value.trim() or replySection.querySelector('img') or replySection.querySelector('.bg-gray-600')
                replyDiv = document.createElement 'div'
                replyDiv.className = 'flex items-start mt-2'
                replyDiv.innerHTML = """
                  <img src="{{ asset('build/images/users/' ~ user.username ~ '.png') }}" alt="{{ user.username }} Avatar" class="w-6 h-6 rounded-full mr-2">
                  <div class="bg-gray-700 p-3 rounded-lg">
                    <p class="text-sm text-purple-400">{{ user.username }}</p>
                    <p class="text-gray-300">#{replyInput.value}</p>
                    #{if replySection.querySelector('img') then "<img src='#{replySection.querySelector('img').src}' class='mt-2 max-h-48 rounded-lg'>" else ''}
                    #{if replySection.querySelector('.bg-gray-600') then "<div class='mt-2'>#{replySection.querySelector('.bg-gray-600').innerHTML}</div>" else ''}
                  </div>
                """
                replySection.insertBefore replyDiv, replySection.querySelector('textarea')
                replyInput.value = ''
                replySection.querySelector('img')?.remove() if replySection.querySelector('img')
                replySection.querySelector('.bg-gray-600')?.remove() if replySection.querySelector('.bg-gray-600')
              emojiPopup.classList.add 'hidden'

      # Load Initial Comments
      loadComments = ->
        if commentsList.children.length == 0
          for i in [1..3]
            comment = document.createElement 'div'
            comment.className = 'flex items-start mb-4'
            comment.innerHTML = """
              <img src="{{ asset('build/images/users/alice.jpg') }}" alt="Alice" class="w-8 h-8 rounded-full mr-2">
              <div class="flex-1">
                <div class="bg-gray-700 p-3 rounded-lg">
                  <p class="text-sm text-purple-400">Alice</p>
                  <p class="text-gray-300">Great post! Loving the insights #{i}.</p>
                </div>
                <div class="flex space-x-4 text-gray-400 mt-2">
                  <button class="reply-btn text-xs hover:text-purple-400 transition">Reply</button>
                  <div class="flex items-center">
                    <svg class="w-4 h-4 mr-1 cursor-pointer hover:text-red-400 transition" fill="currentColor" viewBox="0 0 24 24">
                      <path d="M12 21.35l-1.45-1.32C5.4 15.36 2 12.28 2 8.5 2 5.42 4.42 3 7.5 3c1.74 0 3.41.81 4.5 2.09C13.09 3.81 14.76 3 16.5 3 19.58 3 22 5.42 22 8.5c0 3.78-3.4 6.86-8.55 11.54L12 21.35z"/>
                    </svg>
                    <span class="text-xs">#{Math.floor(Math.random() * 10)}</span>
                  </div>
                </div>
                <div class="ml-10 mt-2 space-y-2 hidden reply-section">
                  <div class="flex items-start">
                    <img src="{{ asset('build/images/users/bob.jpg') }}" alt="Bob" class="w-6 h-6 rounded-full mr-2">
                    <div class="bg-gray-700 p-3 rounded-lg">
                      <p class="text-sm text-purple-400">Bob</p>
                      <p class="text-gray-300">Totally agree with you!</p>
                    </div>
                  </div>
                </div>
              </div>
            """
            commentsList.appendChild comment
            commentCount.textContent = i
            document.getElementById('comment-count-static').textContent = i
          checkCommentVisibility()

      # Check Comment Visibility
      checkCommentVisibility = ->
        visibleComments = Array.from(commentsList.children).slice(0, 5)
        hiddenComments = Array.from(commentsList.children).slice(5)
        for comment in visibleComments
          comment.style.display = 'flex'
        for comment in hiddenComments
          comment.style.display = 'none'
        viewMoreComments.classList.toggle 'hidden', hiddenComments.length == 0

      # View More Comments
      viewMoreComments.addEventListener 'click', ->
        hiddenComments = Array.from(commentsList.children).slice(5)
        for comment in hiddenComments
          comment.style.display = 'flex'
        viewMoreComments.classList.add 'hidden'

      # Live Reactions
      setInterval ->
        if Math.random() > 0.7
          liveReactions.classList.remove 'hidden'
          setTimeout (-> liveReactions.classList.add 'hidden'), 3000
      , 5000

      # Toggle Analytics
      toggleAnalytics.addEventListener 'click', ->
        analyticsOverlay.classList.toggle 'hidden'
        if not analyticsOverlay.classList.contains 'hidden'
          # Mock chart (you can replace with actual charting library)
          document.getElementById('analytics-chart').innerHTML = '<div class="h-32 bg-gray-700 rounded"></div>'

      document.getElementById('close-analytics').addEventListener 'click', ->
        analyticsOverlay.classList.add 'hidden'

      # Like Reaction
      document.querySelector('.group/reaction svg').addEventListener 'click', ->
        likeCount = document.getElementById 'like-count'
        count = parseInt(likeCount.textContent) + 1
        likeCount.textContent = count
        liveReactions.innerHTML = "<span class='text-purple-400 animate-bounce'>👍 #{count}</span>"
        liveReactions.classList.remove 'hidden'
        setTimeout (-> liveReactions.classList.add 'hidden'), 3000

      # Update Post Age
      setInterval ->
        postAge = document.getElementById 'post-age'
        timeDiff = Math.floor((new Date() - new Date()) / 1000)
        postAge.textContent = if timeDiff < 60 then 'Just now' else "#{Math.floor(timeDiff / 60)}m ago"
      , 60000

  loadComments()
