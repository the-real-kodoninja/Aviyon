init = ->
  # 3D Visualization with Three.js
  canvas3d = document.getElementById 'portfolio-3d-chart'
  unless canvas3d
    console.error '3D chart canvas not found'
    return
  scene = new THREE.Scene()
  camera = new THREE.PerspectiveCamera 75, canvas3d.clientWidth / canvas3d.clientHeight, 0.1, 1000
  renderer = new THREE.WebGLRenderer { canvas: canvas3d, alpha: true }
  renderer.setSize canvas3d.clientWidth, canvas3d.clientHeight
  camera.position.z = 5

  geometry = new THREE.SphereGeometry 1.5, 32, 32
  material = new THREE.MeshPhongMaterial { color: 0x8b5cf6, transparent: true, opacity: 0.7 }
  globe = new THREE.Mesh geometry, material
  scene.add globe

  particlesGeometry = new THREE.BufferGeometry()
  positions = []
  for i in [0...500]
    x = (Math.random() - 0.5) * 3
    y = (Math.random() - 0.5) * 3
    z = (Math.random() - 0.5) * 3
    positions.push x, y, z
  particlesGeometry.setAttribute 'position', new THREE.Float32BufferAttribute(positions, 3)
  particlesMaterial = new THREE.PointsMaterial { color: 0x10b981, size: 0.05 }
  particles = new THREE.Points particlesGeometry, particlesMaterial
  scene.add particles

  ambientLight = new THREE.AmbientLight 0x404040
  scene.add ambientLight
  pointLight = new THREE.PointLight 0xffffff, 1, 100
  pointLight.position.set 10, 10, 10
  scene.add pointLight

  animate3d = ->
    requestAnimationFrame animate3d
    globe.rotation.y += 0.005
    particles.rotation.y += 0.002
    renderer.render scene, camera

  animate3d()

  window.addEventListener 'resize', ->
    camera.aspect = canvas3d.clientWidth / canvas3d.clientHeight
    camera.updateProjectionMatrix()
    renderer.setSize canvas3d.clientWidth, canvas3d.clientHeight

  # Candlestick Chart
  ctxCandlestick = document.getElementById 'portfolio-candlestick'
  unless ctxCandlestick
    console.error 'Candlestick chart canvas not found'
    return
  new Chart ctxCandlestick,
    type: 'candlestick'
    data:
      datasets: [
        label: 'AVN Token Price'
        data: [
          { x: new Date('2025-05-01'), o: 100, h: 120, l: 95, c: 115 }
          { x: new Date('2025-05-02'), o: 115, h: 130, l: 110, c: 125 }
          { x: new Date('2025-05-03'), o: 125, h: 140, l: 120, c: 135 }
          { x: new Date('2025-05-04'), o: 135, h: 150, l: 130, c: 145 }
          { x: new Date('2025-05-05'), o: 145, h: 160, l: 140, c: 155 }
        ]
      ]
    options:
      responsive: true
      scales:
        x:
          type: 'time'
          time:
            unit: 'day'
        y:
          title:
            display: true
            text: 'Price ($)'
      plugins:
        legend:
          display: true
        tooltip:
          mode: 'index'
          intersect: false

  # Line Chart for Portfolio Growth
  ctxGrowth = document.getElementById 'portfolio-growth'
  unless ctxGrowth
    console.error 'Growth chart canvas not found'
    return
  new Chart ctxGrowth,
    type: 'line'
    data:
      labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May']
      datasets: [
        label: 'Portfolio Value ($)'
        data: [1000000, 1050000, 1100000, 1150000, 1250000]
        borderColor: 'rgb(59, 130, 246)'
        backgroundColor: 'rgba(59, 130, 246, 0.2)'
        fill: true
        tension: 0.4
      ]
    options:
      responsive: true
      scales:
        y:
          beginAtZero: false
          title:
            display: true
            text: 'Value ($)'
      plugins:
        legend:
          display: true
        tooltip:
          mode: 'index'

  # Bar Chart for Holdings Distribution
  ctxHoldings = document.getElementById 'portfolio-holdings'
  unless ctxHoldings
    console.error 'Holdings chart canvas not found'
    return
  new Chart ctxHoldings,
    type: 'bar'
    data:
      labels: ['AVN Tokens', 'Kodotoken', 'TSLA']
      datasets: [
        label: 'Holdings Value ($)'
        data: [100000, 50000, 30000]
        backgroundColor: ['rgba(34, 197, 94, 0.8)', 'rgba(234, 179, 8, 0.8)', 'rgba(239, 68, 68, 0.8)']
        borderColor: ['rgb(34, 197, 94)', 'rgb(234, 179, 8)', 'rgb(239, 68, 68)']
        borderWidth: 1
      ]
    options:
      responsive: true
      scales:
        y:
          beginAtZero: true
          title:
            display: true
            text: 'Value ($)'
      plugins:
        legend:
          display: true
        tooltip:
          mode: 'index'

module.exports = { init }
