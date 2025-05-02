# Expose libraries to global scope for inline scripts
window.THREE = require('three')
window.GLTFLoader = require('three/examples/jsm/loaders/GLTFLoader.js')
window.Chart = require('chart.js/auto')

# Utility Functions
initThreeCanvas = (canvasId, geometryType = 'box', color = 0x6b48ff, wireframe = true, autoRotate = true) ->
  canvas = document.getElementById(canvasId)
  return unless canvas

  scene = new THREE.Scene()
  camera = new THREE.PerspectiveCamera(75, canvas.clientWidth / canvas.clientHeight, 0.1, 1000)
  renderer = new THREE.WebGLRenderer({ canvas, alpha: true })
  renderer.setSize(canvas.clientWidth, canvas.clientHeight)
  camera.position.z = 5

  light = new THREE.DirectionalLight(0xffffff, 0.8)
  light.position.set(0, 1, 1)
  scene.add(light)
  scene.add(new THREE.AmbientLight(0x404040, 0.5))

  if geometryType == 'box'
    geometry = new THREE.BoxGeometry(1, 1, 1)
    material = new THREE.MeshBasicMaterial({ color, wireframe })
    object = new THREE.Mesh(geometry, material)
  else if geometryType == 'sphere'
    geometry = new THREE.SphereGeometry(1, 32, 32)
    material = new THREE.MeshBasicMaterial({ color, wireframe })
    object = new THREE.Mesh(geometry, material)
  else if geometryType == 'torus'
    geometry = new THREE.TorusKnotGeometry(1, 0.3, 100, 16)
    material = new THREE.MeshBasicMaterial({ color, wireframe })
    object = new THREE.Mesh(geometry, material)

  scene.add(object)

  animate = ->
    requestAnimationFrame(animate)
    if autoRotate
      object.rotation.x += 0.01
      object.rotation.y += 0.01
    renderer.render(scene, camera)
  animate()

  window.addEventListener 'resize', ->
    camera.aspect = canvas.clientWidth / canvas.clientHeight
    camera.updateProjectionMatrix()
    renderer.setSize(canvas.clientWidth, canvas.clientHeight)

initNFTPreview = (canvas, modelUrl) ->
  scene = new THREE.Scene()
  camera = new THREE.PerspectiveCamera(75, canvas.clientWidth / canvas.clientHeight, 0.1, 1000)
  renderer = new THREE.WebGLRenderer({ canvas, alpha: true })
  renderer.setSize(canvas.clientWidth, canvas.clientHeight)
  camera.position.z = 5

  light = new THREE.DirectionalLight(0xffffff, 0.8)
  light.position.set(0, 1, 1)
  scene.add(light)
  scene.add(new THREE.AmbientLight(0x404040, 0.5))

  if modelUrl
    loader = new GLTFLoader()
    loader.load modelUrl, (gltf) ->
      scene.add(gltf.scene)
      gltf.scene.scale.set(1, 1, 1)
      gltf.scene.position.set(0, 0, 0)

      animate = ->
        requestAnimationFrame(animate)
        gltf.scene.rotation.y += 0.01
        renderer.render(scene, camera)
      animate()
    , undefined, (error) ->
      console.error 'Error loading GLTF model:', error
      geometry = new THREE.BoxGeometry(1, 1, 1)
      material = new THREE.MeshBasicMaterial({ color: 0x6b48ff })
      cube = new THREE.Mesh(geometry, material)
      scene.add(cube)

      animate = ->
        requestAnimationFrame(animate)
        cube.rotation.y += 0.01
        renderer.render(scene, camera)
      animate()
  else
    geometry = new THREE.BoxGeometry(1, 1, 1)
    material = new THREE.MeshBasicMaterial({ color: 0x6b48ff })
    cube = new THREE.Mesh(geometry, material)
    scene.add(cube)

    animate = ->
      requestAnimationFrame(animate)
      cube.rotation.y += 0.01
      renderer.render(scene, camera)
    animate()

initModal = (modalId, openSelector, closeSelector) ->
  modal = document.getElementById(modalId)
  openButtons = document.querySelectorAll(openSelector)
  closeButton = document.querySelector(closeSelector)

  openButtons.forEach (btn) ->
    btn.addEventListener 'click', ->
      modal.classList.remove('hidden')

  if closeButton
    closeButton.addEventListener 'click', ->
      modal.classList.add('hidden')

# Initialize Functions Conditionally Based on Page
document.addEventListener 'DOMContentLoaded', ->
  path = window.location.pathname

  if path == '/' or path == '/landing'
    initThreeCanvas('bg-canvas', 'torus', 0x8b5cf6)
    initThreeCanvas('three-canvas', 'icosahedron', 0x6b48ff)

  if path == '/dashboard/marketplace'
    document.querySelectorAll('[id^="nft-"]').forEach (canvas) ->
      initNFTPreview(canvas, canvas.dataset.model)

  console.log 'Aviyon: Core utilities initialized'
