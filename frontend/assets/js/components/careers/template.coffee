document.addEventListener 'DOMContentLoaded', ->
  # Elements
  searchJobs = document.getElementById('search-jobs')
  filterDepartment = document.getElementById('filter-department')
  filterLocation = document.getElementById('filter-location')
  jobListings = document.getElementById('job-listings')
  jobCategories = jobListings.querySelectorAll('.job-category')
  jobCards = jobListings.querySelectorAll('.job-card')
  applicationModal = document.getElementById('application-modal')
  modalContent = document.getElementById('modal-content')
  closeModalBtn = document.getElementById('close-modal')
  aiRecommendations = document.getElementById('ai-recommendations')
  tourElement = document.getElementById('virtual-tour')
  tourPlayBtn = document.getElementById('tour-play')
  tourPauseBtn = document.getElementById('tour-pause')
  tourResetBtn = document.getElementById('tour-reset')
  chatToggle = document.getElementById('chat-toggle')
  chatWindow = document.getElementById('chat-window')
  chatClose = document.getElementById('chat-close')
  chatMessages = document.getElementById('chat-messages')
  chatInput = document.getElementById('chat-input')

  # AI-Driven Recommendations (Mock API Call)
  fetchAIRecommendations = ->
    # Mock API response from nimbus.ai
    mockResponse = [
      { id: 1, title: 'CEO, KodoFilms Studios', company: 'KodoFilms Studios', description: 'Lead 20+ production companies...', matchScore: 92 },
      { id: 3, title: 'Senior AI Engineer, nimbus.ai', company: 'nimbus.ai', description: 'Develop ASI/AGI models...', matchScore: 88 },
      { id: 6, title: 'Social Media Manager, Kodoverse', company: 'Kodoverse', description: 'Boost kodoanime.social presence...', matchScore: 85 }
    ]
    aiRecommendations.innerHTML = ''
    mockResponse.forEach (job) ->
      card = """
        <div class="bg-gray-900 p-6 rounded-xl shadow-lg hover:shadow-xl transition">
          <h4 class="text-xl font-semibold text-white">#{job.title}</h4>
          <p class="text-gray-300 mt-2">#{job.description}</p>
          <p class="text-gray-300 mt-2"><strong>Match Score:</strong> #{job.matchScore}%</p>
          <button class="mt-4 bg-neon-purple text-white px-4 py-2 rounded-lg hover:bg-purple-700 transition" onclick="openModal('/careers/job/#{job.id}')">Apply Now</button>
        </div>
      """
      aiRecommendations.innerHTML += card

  # 3D Virtual Tour with GLTF Model
  scene = new THREE.Scene()
  camera = new THREE.PerspectiveCamera(75, tourElement.clientWidth / tourElement.clientHeight, 0.1, 1000)
  renderer = new THREE.WebGLRenderer({ alpha: true, antialias: true })
  renderer.setSize(tourElement.clientWidth, tourElement.clientHeight)
  tourElement.appendChild(renderer.domElement)

  light = new THREE.DirectionalLight(0xffffff, 1)
  light.position.set(5, 5, 5)
  scene.add(light)

  ambientLight = new THREE.AmbientLight(0x404040)
  scene.add(ambientLight)

  loader = new THREE.GLTFLoader()
  cityModel = null
  camera.position.set(0, 5, 10)

  loader.load(
    '{{ asset('build/models/kodocity.gltf') }}', # Placeholder path for the GLTF model
    (gltf) ->
      cityModel = gltf.scene
      scene.add(cityModel)
      cityModel.position.set(0, 0, 0)
      cityModel.scale.set(0.5, 0.5, 0.5)
    undefined
    (error) -> console.error('Error loading GLTF model:', error)
  )

  isTourPlaying = false
  rotationSpeed = 0.005

  animateTour = ->
    if isTourPlaying and cityModel
      requestAnimationFrame(animateTour)
      cityModel.rotation.y += rotationSpeed
      renderer.render(scene, camera)

  tourPlayBtn.addEventListener 'click', ->
    isTourPlaying = true
    tourPlayBtn.classList.add('hidden')
    tourPauseBtn.classList.remove('hidden')
    animateTour()

  tourPauseBtn.addEventListener 'click', ->
    isTourPlaying = false
    tourPauseBtn.classList.add('hidden')
    tourPlayBtn.classList.remove('hidden')

  tourResetBtn.addEventListener 'click', ->
    isTourPlaying = false
    tourPauseBtn.classList.add('hidden')
    tourPlayBtn.classList.remove('hidden')
    if cityModel
      cityModel.rotation.y = 0
    camera.position.set(0, 5, 10)
    camera.lookAt(0, 0, 0)

  window.addEventListener 'resize', ->
    camera.aspect = tourElement.clientWidth / tourElement.clientHeight
    camera.updateProjectionMatrix()
    renderer.setSize(tourElement.clientWidth, tourElement.clientHeight)

  # Filter and Search Jobs
  filterJobs = ->
    searchTerm = searchJobs.value.toLowerCase()
    selectedDepartment = filterDepartment.value
    selectedLocation = filterLocation.value

    jobCategories.forEach (category) ->
      category.style.display = 'none'
      category.querySelectorAll('.job-card').forEach (card) ->
        card.style.display = 'none'

    matchesFound = false
    jobCards.forEach (card) ->
      title = card.querySelector('h4').textContent.toLowerCase()
      departmentMatch = selectedDepartment is '' or card.parentElement.parentElement.dataset.department is selectedDepartment
      locationMatch = selectedLocation is '' or card.dataset.location is selectedLocation
      searchMatch = searchTerm is '' or title.includes(searchTerm)

      if departmentMatch and locationMatch and searchMatch
        card.style.display = 'block'
        card.parentElement.parentElement.style.display = 'block'
        matchesFound = true

    if not matchesFound
      jobListings.innerHTML = '<p class="text-gray-400 text-center text-xl">No matching positions found. Try adjusting your search or filters.</p>'

  # Event Listeners for Filters and Search
  searchJobs.addEventListener 'input', filterJobs
  filterDepartment.addEventListener 'change', filterJobs
  filterLocation.addEventListener 'change', filterJobs

  # Modal Handling with AI Match Score
  openModal = (url) ->
    fetch(url)
      .then((response) -> response.text())
      .then((html) ->
        modalContent.innerHTML = html
        applicationModal.classList.remove('hidden')
        # Mock AI match score calculation
        setTimeout(->
          matchScore = Math.floor(Math.random() * (95 - 75 + 1)) + 75 # Random score between 75-95%
          modalContent.querySelector('#ai-match-score')?.textContent = "#{matchScore}%"
        , 1000)
      )
      .catch((error) -> console.error('Error loading job details:', error))

  closeModalBtn.addEventListener 'click', ->
    applicationModal.classList.add('hidden')
    modalContent.innerHTML = ''

  window.openModal = openModal

  # Live Chat with WebSocket
  ws = new WebSocket('ws://localhost:8080') # Placeholder WebSocket URL
  ws.onopen = ->
    addChatMessage('System', 'Connected to Aviyon Support. How can we assist you?')

  ws.onmessage = (event) ->
    data = JSON.parse(event.data)
    addChatMessage('Support', data.message)

  ws.onclose = ->
    addChatMessage('System', 'Chat disconnected. Please refresh to reconnect.')

  addChatMessage = (sender, message) ->
    msgDiv = document.createElement('div')
    msgDiv.className = if sender is 'You' then 'text-right' else 'text-left'
    msgDiv.innerHTML = """
      <p class="text-sm text-gray-400">#{sender}</p>
      <p class="bg-#{if sender is 'You' then 'neon-purple' else 'gray-700'} text-white p-2 rounded-lg inline-block">#{message}</p>
    """
    chatMessages.appendChild(msgDiv)
    chatMessages.scrollTop = chatMessages.scrollHeight

  chatToggle.addEventListener 'click', ->
    chatWindow.classList.toggle('hidden')

  chatClose.addEventListener 'click', ->
    chatWindow.classList.add('hidden')

  chatInput.addEventListener 'keypress', (e) ->
    if e.key is 'Enter' and chatInput.value.trim() isnt ''
      message = chatInput.value
      addChatMessage('You', message)
      ws.send(JSON.stringify({ message: message }))
      chatInput.value = ''

  # Initial Setup
  fetchAIRecommendations()
  filterJobs()
