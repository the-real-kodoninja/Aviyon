import * as THREE from 'three';

export function initLanding() {
  const canvas = document.getElementById('three-canvas');
  if (!canvas) return;

  console.log('Three.js canvas found, initializing scene...');

  canvas.style.display = 'block';
  canvas.style.width = '100%';
  canvas.style.height = '100%';

  const scene = new THREE.Scene();
  const camera = new THREE.PerspectiveCamera(75, window.innerWidth / window.innerHeight, 0.1, 1000);
  const renderer = new THREE.WebGLRenderer({ alpha: true });
  renderer.setSize(window.innerWidth, window.innerHeight);
  canvas.appendChild(renderer.domElement);
  console.log('Renderer initialized and appended to canvas. Canvas size:', window.innerWidth, 'x', window.innerHeight);

  const gl = renderer.getContext();
  if (!gl) {
    console.error('Failed to get WebGL context!');
  } else {
    console.log('WebGL context created successfully.');
  }

  // Background Nodes
  const nodes = [];
  const nodeCount = 3; // Reduced for performance
  const geometry = new THREE.SphereGeometry(0.2, 8, 8);
  for (let i = 0; i < nodeCount; i++) {
    const material = new THREE.MeshBasicMaterial({
      color: 0x6b48ff, // Purple for cyberpunk aesthetic
      transparent: true,
      opacity: 0.5
    });
    const node = new THREE.Mesh(geometry, material);
    node.position.set(
      (Math.random() - 0.5) * 40,
      (Math.random() - 0.5) * 30,
      (Math.random() - 0.5) * 20
    );
    scene.add(node);
    nodes.push(node);
  }

  // Subtle Lines
  const lineMaterial = new THREE.LineBasicMaterial({ color: 0x2A6DD1, opacity: 0.1, transparent: true });
  for (let i = 0; i < nodeCount; i++) {
    for (let j = i + 1; j < nodeCount; j++) {
      const points = [];
      points.push(nodes[i].position);
      points.push(nodes[j].position);
      const geometry = new THREE.BufferGeometry().setFromPoints(points);
      const line = new THREE.Line(geometry, lineMaterial);
      scene.add(line);
    }
  }

  camera.position.z = 50;

  const animate = () => {
    requestAnimationFrame(animate);
    nodes.forEach((node) => {
      node.position.x += Math.sin(Date.now() * 0.001 + node.position.y) * 0.02;
      node.position.y += Math.cos(Date.now() * 0.001 + node.position.x) * 0.02;
    });
    renderer.render(scene, camera);
  };
  animate();

  window.addEventListener('resize', () => {
    camera.aspect = window.innerWidth / window.innerHeight;
    camera.updateProjectionMatrix();
    renderer.setSize(window.innerWidth, window.innerHeight);
    console.log('Window resized. New canvas size:', window.innerWidth, 'x', window.innerHeight);
  });

  console.log('Three.js scene initialized with', nodeCount, 'nodes');
}
