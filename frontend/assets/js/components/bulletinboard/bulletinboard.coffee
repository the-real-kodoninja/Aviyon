# assets/js/components/bulletinboard/bulletinboard.coffee

class BulletinBoard
  constructor: ->
    @feed = document.getElementById('bulletin-feed')
    @modal = document.getElementById('bulletin-modal')
    @newBtn = document.getElementById('new-bulletin-btn')
    @aiAssistBtn = document.getElementById('ai-assist-btn')
    @categoryFilter = document.getElementById('category-filter')
    @locationFilter = document.getElementById('location-filter')
    @searchInput = document.getElementById('search-bulletin')
    @filterBtn = document.getElementById('filter-btn')
    @prevPage = document.getElementById('prev-page')
    @nextPage = document.getElementById('next-page')
    @pageInfo = document.getElementById('page-info')
    @viewCount = document.getElementById('view-count')
    @engagementRate = document.getElementById('engagement-rate')
    @activeUsers = document.getElementById('active-users')
    @chartCanvas = document.getElementById('engagement-chart').getContext('2d')
    @globeContainer = document.getElementById('bulletin-globe')
    @chatToggle = document.getElementById('chat-toggle')
    @chatWindow = document.getElementById('chat-window')
    @chatMessages = document.getElementById('chat-messages')
    @chatInput = document.getElementById('chat-input')
    @chatClose = document.getElementById('chat-close')
    @assistantToggle = document.getElementById('assistant-toggle')
    @assistantWindow = document.getElementById('assistant-window')
    @assistantMessages = document.getElementById('assistant-messages')
    @assistantInput = document.getElementById('assistant-input')
    @assistantClose = document.getElementById('assistant-close')
    @currentPage = 1
    @perPage = 6
    @bulletins = []
    @csrfToken = document.querySelector('meta[name="csrf-token-bulletin"]')?.content or ''

    @setupEvents()
    @loadBulletins()
    @initChart()
    @initGlobe()
    @initLiveChat()
    @initVirtualAssistant()

  setupEvents: ->
    @newBtn.addEventListener 'click', @openModal.bind(@)
    @aiAssistBtn.addEventListener 'click', @triggerAIAssist.bind(@)
    @filterBtn.addEventListener 'click', @filterBulletins.bind(@)
    @searchInput.addEventListener 'input', @debounce(@filterBulletins.bind(@), 300)
    @prevPage.addEventListener 'click', @prevPageClick.bind(@)
    @nextPage.addEventListener 'click', @nextPageClick.bind(@)
    document.addEventListener 'keydown', (e) => @closeModal() if e.key == 'Escape' and !@modal.classList.contains('hidden')

  debounce: (func, wait) ->
    timeout = null
    => 
      clearTimeout(timeout)
      timeout = setTimeout(func, wait)

  loadBulletins: ->
    fetch('/api/bulletin/list', {
      headers: { 'X-CSRF-Token': @csrfToken }
    })
    .then (response) => response.json()
    .then (data) =>
      @bulletins = data
      @renderBulletins()
      @updateAnalytics()

  renderBulletins: ->
    @feed.innerHTML = ''
    start = (@currentPage - 1) * @perPage
    end = start + @perPage
    paginated = @bulletins.slice(start, end).filter(@applyFilters.bind(@))
    for bulletin in paginated
      @feed.insertAdjacentHTML 'beforeend', @bulletinTemplate(bulletin)
    @updatePageInfo()
    @setupCardEvents()

  applyFilters: (bulletin) ->
    categoryMatch = !@categoryFilter.value or bulletin.category == @categoryFilter.value
    locationMatch = !@locationFilter.value or bulletin.location == @locationFilter.value
    searchMatch = !@searchInput.value or bulletin.title.toLowerCase().includes(@searchInput.value.toLowerCase()) or bulletin.content.toLowerCase().includes(@searchInput.value.toLowerCase())
    categoryMatch and locationMatch and searchMatch

  bulletinTemplate: (bulletin) ->
    """
    <div class="bulletin-card holographic-card p-6 rounded-xl shadow-lg hover:shadow-xl transition-all neon-border float" data-tilt data-tilt-max="15">
      <div class="flex items-center mb-4">
        <img src="#{asset('images/users/' + bulletin.author.toLowerCase() + '.jpg') || asset('images/users/default.jpg')}" alt="#{bulletin.author} Photo" class="w-14 h-14 rounded-full mr-4 border-2 border-[var(--neon-purple)]">
        <div>
          <p class="text-sm text-[var(--neon-purple)] font-semibold">#{bulletin.author}</p>
          <p class="text-xs text-gray-400">#{bulletin.date} | #{bulletin.location}</p>
          <span class="text-xs text-[var(--neon-blue)]">#{bulletin.category.charAt(0).toUpperCase() + bulletin.category.slice(1)}</span>
        </div>
      </div>
      <h3 class="text-2xl text-[var(--neon-blue)] mb-3 neon-glow">#{bulletin.title}</h3>
      <p class="text-gray-200 mb-4">#{bulletin.content.substring(0, 150)}#{if bulletin.content.length > 150 then '...' else ''}</p>
      #{if bulletin.media == 'image' then "<img src=\"#{bulletin.mediaSrc}\" alt=\"Bulletin Media\" class=\"w-full h-64 object-cover rounded-lg mb-4 transform hover:scale-105 transition\">" else if bulletin.media == 'video' then "<video controls class=\"w-full h-64 object-cover rounded-lg mb-4\"><source src=\"#{bulletin.mediaSrc}\" type=\"video/mp4\">Your browser does not support the video tag.</video>" else ''}
      <div class="flex justify-between items-center text-gray-400 mb-4">
        <div class="flex gap-3">
          <button class="like-btn hover:text-[var(--neon-purple)] transition">
            <svg class="w-5 h-5 inline mr-1" fill="currentColor" viewBox="0 0 24 24">
              <path d="M12 21.35l-1.45-1.32C5.4 15.36 2 12.28 2 8.5 2 5.42 4.42 3 7.5 3c1.74 0 3.41.81 4.5 2.09C13.09 3.81 14.76 3 16.5 3 19.58 3 22 5.42 22 8.5c0 3.78-3.4 6.86-8.55 11.54L12 21.35z"/>
            </svg>
            <span class="like-count">#{bulletin.likes}</span>
          </button>
          <button class="comment-btn hover:text-[var(--neon-blue)] transition">
            <svg class="w-5 h-5 inline mr-1" fill="currentColor" viewBox="0 0 24 24">
              <path d="M20 2H4c-1.1 0-2 .9-2 2v18l4-4h14c1.1 0 2-.9 2-2V4c0-1.1-.9-2-2-2zm-7 12h-2v-2h2v2zm0-4h-2V6h2v4z"/>
            </svg>
            <span class="comment-count">#{bulletin.comments}</span>
          </button>
        </div>
        <button class="share-btn hover:text-[var(--neon-green)] transition">
          <svg class="w-5 h-5 inline mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8.684 13.342C8.886 12.938 9 12.482 9 12c0-.482-.114-.938-.316-1.342m0 2.684a3 3 0 110-2.684m0 2.684l6.632 3.316m-6.632-6l6.632-3.316m0 0a3 3 0 105.367-2.684 3 3 0 00-5.367 2.684zm0 9.316a3 3 0 105.367 2.684 3 3 0 00-5.367-2.684z"/>
          </svg>
          Share
        </button>
      </div>
      <button class="w-full bg-[var(--neon-green)] text-white px-4 py-2 rounded-lg hover:bg-green-600 transition-all">Explore Post</button>
    </div>
    """

  setupCardEvents: ->
    document.querySelectorAll('.bulletin-card .like-btn').forEach (btn) =>
      btn.addEventListener 'click', (e) =>
        countEl = e.currentTarget.querySelector('.like-count')
        count = parseInt(countEl.textContent)
        countEl.textContent = count + 1
    document.querySelectorAll('.bulletin-card .comment-btn').forEach (btn) =>
      btn.addEventListener 'click', (e) =>
        countEl = e.currentTarget.querySelector('.comment-count')
        countEl.textContent = parseInt(countEl.textContent) + 1
    document.querySelectorAll('.bulletin-card .share-btn').forEach (btn) =>
      btn.addEventListener 'click', => alert 'Share functionality coming soon!'

  updatePageInfo: ->
    totalPages = Math.ceil(@bulletins.length / @perPage)
    @pageInfo.textContent = "Page #{@currentPage} of #{totalPages}"

  prevPageClick: => @changePage(@currentPage - 1) if @currentPage > 1
  nextPageClick: => @changePage(@currentPage + 1) if @currentPage < Math.ceil(@bulletins.length / @perPage)
  changePage: (page) ->
    @currentPage = page
    @renderBulletins()

  filterBulletins: ->
    @currentPage = 1
    @renderBulletins()
    @fetchAISuggestions()

  fetchAISuggestions: ->
    fetch('/api/ai/assist', {
      method: 'POST',
      headers: { 'X-CSRF-Token': @csrfToken, 'Content-Type': 'application/json' },
      body: JSON.stringify({ prompt: "Suggest a search query for #{@searchInput.value}" })
    })
    .then (response) => response.json()
    .then (data) =>
      suggestionEl = document.getElementById('suggestion-text')
      suggestionEl.textContent = data.suggestion
      document.getElementById('ai-suggestions').classList.remove('hidden')

  triggerAIAssist: ->
    fetch('/api/ai/assist', {
      method: 'POST',
      headers: { 'X-CSRF-Token': @csrfToken, 'Content-Type': 'application/json' },
      body: JSON.stringify({ prompt: 'Suggest a bulletin post' })
    })
    .then (response) => response.json()
    .then (data) =>
      @modal.classList.remove('hidden')
      document.getElementById('bulletin-editor').innerHTML = data.suggestion

  initChart: ->
    new Chart @chartCanvas,
      type: 'line'
      data:
        labels: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
        datasets: [
          label: 'Engagement'
          data: [65, 78, 66, 85, 90, 82, 88]
          borderColor: 'rgba(59, 130, 246, 1)'
          backgroundColor: 'rgba(59, 130, 246, 0.2)'
          fill: true
        ]
      options:
        responsive: true
        maintainAspectRatio: false

  updateAnalytics: ->
    @viewCount.textContent = Math.floor(Math.random() * 5000) + 1000
    @engagementRate.textContent = "#{((Math.random() * 20) + 70).toFixed(1)}%"
    @activeUsers.textContent = Math.floor(Math.random() * 1000) + 500

  initGlobe: ->
    scene = new THREE.Scene()
    camera = new THREE.PerspectiveCamera(75, @globeContainer.clientWidth / @globeContainer.clientHeight, 0.1, 1000)
    renderer = new THREE.WebGLRenderer({ antialias: true })
    renderer.setSize(@globeContainer.clientWidth, @globeContainer.clientHeight)
    @globeContainer.appendChild(renderer.domElement)

    geometry = new THREE.SphereGeometry(5, 32, 32)
    material = new THREE.MeshBasicMaterial({
      color: 0x3b82f6
      wireframe: true
      transparent: true
      opacity: 0.5
    })
    globe = new THREE.Mesh(geometry, material)
    scene.add(globe)

    camera.position.z = 10

    controls = new THREE.OrbitControls(camera, renderer.domElement)
    controls.enableDamping = true

    # Add bulletin points on the globe
    for bulletin in @bulletins
      lat = Math.random() * 180 - 90
      lon = Math.random() * 360 - 180
      phi = (90 - lat) * Math.PI / 180
      theta = lon * Math.PI / 180
      radius = 5.1
      x = radius * Math.sin(phi) * Math.cos(theta)
      y = radius * Math.cos(phi)
      z = radius * Math.sin(phi) * Math.sin(theta)

      pointGeo = new THREE.SphereGeometry(0.1, 16, 16)
      pointMat = new THREE.MeshBasicMaterial({ color: 0xa855f7 })
      point = new THREE.Mesh(pointGeo, pointMat)
      point.position.set(x, y, z)
      scene.add(point)

    animate = =>
      requestAnimationFrame(animate)
      controls.update()
      renderer.render(scene, camera)
    animate()

    document.getElementById('globe-rotate').addEventListener 'click', =>
      controls.autoRotate = !controls.autoRotate
    document.getElementById('globe-reset').addEventListener 'click', =>
      camera.position.z = 10
      controls.reset()

  initLiveChat: ->
    @chatToggle.addEventListener 'click', =>
      @chatWindow.classList.toggle('hidden')
    @chatClose.addEventListener 'click', =>
      @chatWindow.classList.add('hidden')
    @chatInput.addEventListener 'keypress', (e) =>
      if e.key == 'Enter' and @chatInput.value.trim()
        message = @chatInput.value
        @chatMessages.insertAdjacentHTML 'beforeend', """
          <div class="text-gray-200 mb-2">
            <span class="text-[var(--neon-purple)]">You:</span> #{message}
          </div>
        """
        @chatInput.value = ''
        @chatMessages.scrollTop = @chatMessages.scrollHeight
        # Mock response
        setTimeout =>
          @chatMessages.insertAdjacentHTML 'beforeend', """
            <div class="text-gray-200 mb-2">
              <span class="text-[var(--neon-blue)]">Support:</span> Thanks for your message! How can we assist you today?
            </div>
          """
          @chatMessages.scrollTop = @chatMessages.scrollHeight
        , 1000

  initVirtualAssistant: ->
    @assistantToggle.addEventListener 'click', =>
      @assistantWindow.classList.toggle('hidden')
    @assistantClose.addEventListener 'click', =>
      @assistantWindow.classList.add('hidden')
    @assistantInput.addEventListener 'keypress', (e) =>
      if e.key == 'Enter' and @assistantInput.value.trim()
        message = @assistantInput.value
        @assistantMessages.insertAdjacentHTML 'beforeend', """
          <div class="text-gray-200 mb-2">
            <span class="text-[var(--neon-blue)]">You:</span> #{message}
          </div>
        """
        @assistantInput.value = ''
        @assistantMessages.scrollTop = @assistantMessages.scrollHeight
        fetch('/api/ai/assist', {
          method: 'POST',
          headers: { 'X-CSRF-Token': @csrfToken, 'Content-Type': 'application/json' },
          body: JSON.stringify({ prompt: message })
        })
        .then (response) => response.json()
        .then (data) =>
          @assistantMessages.insertAdjacentHTML 'beforeend', """
            <div class="text-gray-200 mb-2">
              <span class="text-[var(--neon-blue)]">Nimbus.ai:</span> #{data.suggestion}
            </div>
          """
          @assistantMessages.scrollTop = @assistantMessages.scrollHeight

  openModal: -> @modal.classList.remove('hidden')
  closeModal: -> @modal.classList.add('hidden')

document.addEventListener 'DOMContentLoaded', -> new BulletinBoard()
