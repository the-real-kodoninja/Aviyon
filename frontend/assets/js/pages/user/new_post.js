document.addEventListener 'DOMContentLoaded', ->
  input = document.getElementById 'post-input'
  photoInput = document.getElementById 'post-photo'
  videoInput = document.getElementById 'post-video'
  submitBtn = document.getElementById 'post-submit'
  previewPhotos = document.getElementById 'preview-photos'
  previewVideos = document.getElementById 'preview-videos'
  postsContainer = document.querySelector('.posts-container')

  # Expand textarea on focus with max height
  input.addEventListener 'focus', ->
    input.rows = 3
  input.addEventListener 'blur', ->
    input.rows = 1 if input.value.trim() == ''
    input.style.overflowY = 'auto' if input.scrollHeight > 200

  # Photo Preview
  photoInput.addEventListener 'change', (e) ->
    files = e.target.files
    previewPhotos.innerHTML = ''
    previewPhotos.classList.remove 'hidden'
    for file in files
      img = document.createElement 'img'
      img.src = URL.createObjectURL(file)
      img.className = 'w-full max-h-48 rounded-lg object-cover'
      previewPhotos.appendChild img

  # Video Preview
  videoInput.addEventListener 'change', (e) ->
    files = e.target.files
    previewVideos.innerHTML = ''
    previewVideos.classList.remove 'hidden'
    for file in files
      video = document.createElement 'video'
      video.controls = true
      source = document.createElement 'source'
      source.src = URL.createObjectURL(file)
      source.type = 'video/mp4'
      video.appendChild source
      video.className = 'w-full max-h-48 rounded-lg'
      previewVideos.appendChild video

  # Submit Post
  submitBtn.addEventListener 'click', ->
    text = input.value.trim()
    if text or previewPhotos.children.length or previewVideos.children.length
      newPost = document.createElement 'div'
      newPost.className = 'bg-gray-800 p-6 rounded-xl shadow-lg mb-6 neon-glow'
      content = """
        <div class="flex items-center mb-4">
          <img src="{{ asset('build/images/users/' ~ user.username ~ '.png') }}" alt="{{ user.username }} Avatar" class="w-8 h-8 rounded-full mr-2">
          <div>
            <p class="text-sm text-purple-400">{{ user.username }}</p>
            <p class="text-xs text-gray-400">Just now</p>
          </div>
        </div>
        <p class="text-gray-300 mb-4">#{text}</p>
      """
      if previewPhotos.children.length
        content += '<div class="grid grid-cols-1 md:grid-cols-2 gap-4 mb-4">'
        for img in previewPhotos.children
          content += "<img src='#{img.src}' class='w-full max-h-48 rounded-lg object-cover'>"
        content += '</div>'
      if previewVideos.children.length
        content += '<div class="grid grid-cols-1 md:grid-cols-2 gap-4 mb-4">'
        for video in previewVideos.children
          content += "<video controls class='w-full max-h-48 rounded-lg'><source src='#{video.querySelector('source').src}' type='video/mp4'></video>"
        content += '</div>'
      content += """
        <div class="flex space-x-4 text-gray-400">
          <div class="flex items-center"><svg class="w-5 h-5 mr-1" fill="currentColor" viewBox="0 0 24 24"><path d="M12 21.35l-1.45-1.32C5.4 15.36 2 12.28 2 8.5 2 5.42 4.42 3 7.5 3c1.74 0 3.41.81 4.5 2.09C13.09 3.81 14.76 3 16.5 3 19.58 3 22 5.42 22 8.5c0 3.78-3.4 6.86-8.55 11.54L12 21.35z"/></svg><span>0</span></div>
          <div class="flex items-center"><svg class="w-5 h-5 mr-1" fill="currentColor" viewBox="0 0 24 24"><path d="M18 16.08c-.76 0-1.44.3-1.96.77L8.91 12.7c.05-.23.09-.46.09-.7s-.04-.47-.09-.70l7.05-4.11c.54.5 1.25.81 2.04.81 1.66 0 3-1.34 3-3s-1.34-3-3-3-3 1.34-3 3c0 .24.04.47.09.70L8.04 9.81C7.5 9.31 6.79 9 6 9c-1.66 0-3 1.34-3 3s1.34 3 3 3c.79 0 1.5-.31 2.04-.81l7.12 4.16c-.05.21-.08.43-.08.65 0 1.61 1.31 2.92 2.92 2.92s2.92-1.31 2.92-2.92c0-1.61-1.31-2.92-2.92-2.92zM18 4c.55 0 1 .45 1 1s-.45 1-1 1-1-.45-1-1 .45-1 1-1zM6 13c-.55 0-1-.45-1-1s.45-1 1-1 1 .45 1 1-.45 1-1 1zm12 7.02c-.55 0-1-.45-1-1s.45-1 1-1 1 .45 1 1-.45 1-1 1z"/></svg><span>0</span></div>
          <div class="flex items-center"><svg class="w-5 h-5 mr-1" fill="currentColor" viewBox="0 0 24 24"><path d="M17 3H7c-1.1 0-2 .9-2 2v14c0 1.1.9 2 2 2h10c1.1 0 2-.9 2-2V5c0-1.1-.9-2-2-2zm0 16H7V5h10v14zm-5-9c1.66 0 3-1.34 3-3s-1.34-3-3-3-3 1.34-3 3 1.34 3 3 3zm0-4c.55 0 1 .45 1 1s-.45 1-1 1-1-.45-1-1 .45-1 1-1zm0 6c-2.76 0-5 1.79-5 4h10c0-2.21-2.24-4-5-4zm0 2c1.38 0 2.5 1.1 2.5 2.45h-5C9.5 14.1 10.62 13 12 13z"/></svg><span>0</span></div>
          <div class="flex items-center relative group"><svg class="w-5 h-5 mr-1" fill="currentColor" viewBox="0 0 24 24"><path d="M19 5v14H5V5h14m0-2H5c-1.1 0-2 .9-2 2v14c0 1.1.9 2 2 2h14c1.1 0 2-.9 2-2V5c0-1.1-.9-2-2-2zm-7 9c-1.66 0-3 1.34-3 3s1.34 3 3 3 3-1.34 3-3-1.34-3-3-3zm0 4c-.55 0-1-.45-1-1s.45-1 1-1 1 .45 1 1-.45 1-1 1zm-6-6h12v2H6zm0 4h8v2H6z"/></svg><span>0</span></div>
        </div>
      """
      postsContainer.insertBefore newPost, postsContainer.firstChild
      input.value = ''
      input.rows = 1
      previewPhotos.innerHTML = ''
      previewVideos.innerHTML = ''
      previewPhotos.classList.add 'hidden'
      previewVideos.classList.add 'hidden'
