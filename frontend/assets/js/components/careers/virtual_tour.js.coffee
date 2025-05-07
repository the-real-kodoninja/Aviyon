document.addEventListener 'DOMContentLoaded', ->
  # Elements
  tourElement = document.getElementById('virtual-tour')
  tourPlayBtn = document.getElementById('tour-play')
  tourPauseBtn = document.getElementById('tour-pause')
  tourResetBtn = document.getElementById('tour-reset')

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
    '/build/models/kodocity.gltf', # Hardcoded path since this is in compiled JS
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
