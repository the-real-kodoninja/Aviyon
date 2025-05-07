init = ->
  canvas = document.getElementById 'portfolio-3d-chart'
  return unless canvas

  scene = new THREE.Scene()
  camera = new THREE.PerspectiveCamera 75, canvas.clientWidth / canvas.clientHeight, 0.1, 1000
  renderer = new THREE.WebGLRenderer canvas: canvas, alpha: true
  renderer.setSize canvas.clientWidth, canvas.clientHeight
  camera.position.z = 5

  geometry = new THREE.TorusGeometry 1, 0.3, 16, 100
  material = new THREE.MeshBasicMaterial color: 0x8b5cf6, wireframe: true
  torus = new THREE.Mesh geometry, material
  scene.add torus

  animate = ->
    requestAnimationFrame animate
    torus.rotation.x += 0.01
    torus.rotation.y += 0.01
    renderer.render scene, camera

  animate()

  window.addEventListener 'resize', ->
    camera.aspect = canvas.clientWidth / canvas.clientHeight
    camera.updateProjectionMatrix()
    renderer.setSize canvas.clientWidth, canvas.clientHeight

module.exports = { init }
