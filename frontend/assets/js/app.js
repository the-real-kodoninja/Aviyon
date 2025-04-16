import '../css/app.css';
import * as THREE from 'three';

// Debug: Check if Three.js is loaded
console.log('Three.js version:', THREE.REVISION);

// Three.js Scene for Hero Background
const canvas = document.getElementById('three-canvas');
if (!canvas) {
  console.error('Three.js canvas element not found! Check if #three-canvas exists in the DOM.');
} else {
  console.log('Three.js canvas found, initializing scene...');

  // Ensure the canvas is visible
  canvas.style.display = 'block';

  const scene = new THREE.Scene();
  const camera = new THREE.PerspectiveCamera(75, window.innerWidth / window.innerHeight, 0.1, 1000);
  const renderer = new THREE.WebGLRenderer({ alpha: true });
  renderer.setSize(window.innerWidth, window.innerHeight);
  canvas.appendChild(renderer.domElement);
  console.log('Renderer initialized and appended to canvas.');

  // Enhanced Nodes (more dynamic and colorful)
  const nodes = [];
  const nodeCount = 8;
  const geometry = new THREE.SphereGeometry(0.4, 16, 16);
  const colors = [0x00D4FF, 0xFF00E5, 0x00FF85]; // Neon blue, magenta, green

  for (let i = 0; i < nodeCount; i++) {
    const material = new THREE.MeshBasicMaterial({
      color: colors[i % colors.length],
      transparent: true,
      opacity: 0.7
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

  // Dynamic Lines with Glowing Effect
  const lineMaterial = new THREE.LineBasicMaterial({ color: 0xFF00E5, opacity: 0.3, transparent: true });
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
      node.position.x += Math.sin(Date.now() * 0.001 + node.position.y) * 0.03;
      node.position.y += Math.cos(Date.now() * 0.001 + node.position.x) * 0.03;
      node.position.z += Math.sin(Date.now() * 0.002 + node.position.z) * 0.02;
    });
    renderer.render(scene, camera);
  };
  animate();

  window.addEventListener('resize', () => {
    camera.aspect = window.innerWidth / window.innerHeight;
    camera.updateProjectionMatrix();
    renderer.setSize(window.innerWidth, window.innerHeight);
  });

  console.log('Three.js scene initialized with', nodeCount, 'nodes');
}

console.log('Aviyon: Web3 Cloud Platform initialized');
