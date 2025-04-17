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
  const nodeCount = 5;
  const geometry = new THREE.SphereGeometry(0.2, 8, 8);
  for (let i = 0; i < nodeCount; i++) {
    const material = new THREE.MeshBasicMaterial({
      color: 0x2A6DD1,
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

  // Thundering Cloud
  const thunderCloud = document.getElementById('thunder-cloud');
  if (thunderCloud) {
    const thunderScene = new THREE.Scene();
    const thunderCamera = new THREE.PerspectiveCamera(75, 2, 0.1, 1000);
    const thunderRenderer = new THREE.WebGLRenderer({ alpha: true });
    thunderRenderer.setSize(200, 100);
    thunderCloud.appendChild(thunderRenderer.domElement);

    const cloudNodes = [];
    const cloudNodeCount = 8;
    const cloudGeometry = new THREE.SphereGeometry(0.15, 8, 8);
    for (let i = 0; i < cloudNodeCount; i++) {
      const material = new THREE.MeshBasicMaterial({
        color: 0xF5F5F5,
        transparent: true,
        opacity: 0.4
      });
      const node = new THREE.Mesh(cloudGeometry, material);
      node.position.set(
        (Math.random() - 0.5) * 10,
        (Math.random() - 0.5) * 5,
        (Math.random() - 0.5) * 5
      );
      thunderScene.add(node);
      cloudNodes.push(node);
    }

    const cloudLineMaterial = new THREE.LineBasicMaterial({ color: 0xF5F5F5, opacity: 0.2, transparent: true });
    for (let i = 0; i < cloudNodeCount; i++) {
      for (let j = i + 1; j < cloudNodeCount; j++) {
        const points = [];
        points.push(cloudNodes[i].position);
        points.push(cloudNodes[j].position);
        const geometry = new THREE.BufferGeometry().setFromPoints(points);
        const line = new THREE.Line(geometry, cloudLineMaterial);
        thunderScene.add(line);
      }
    }

    // Lightning Effect
    let lightningIntensity = 0;
    const lightningMaterial = new THREE.MeshBasicMaterial({ color: 0xF5F5F5, transparent: true, opacity: 0 });
    const lightningGeometry = new THREE.SphereGeometry(5, 16, 16);
    const lightning = new THREE.Mesh(lightningGeometry, lightningMaterial);
    thunderScene.add(lightning);

    thunderCamera.position.z = 15;

    const animateThunder = () => {
      requestAnimationFrame(animateThunder);
      cloudNodes.forEach((node) => {
        node.position.x += Math.sin(Date.now() * 0.001 + node.position.y) * 0.01;
        node.position.y += Math.cos(Date.now() * 0.001 + node.position.x) * 0.01;
      });

      if (Math.random() < 0.015) {
        lightningIntensity = 0.6;
      }
      lightningIntensity = Math.max(0, lightningIntensity - 0.05);
      lightningMaterial.opacity = lightningIntensity;

      thunderRenderer.render(thunderScene, thunderCamera);
    };
    animateThunder();
  }

  // Cursor Nimbus Cloud
  const nimbusCloud = document.getElementById('nimbus-cloud');
  if (nimbusCloud) {
    const nimbusScene = new THREE.Scene();
    const nimbusCamera = new THREE.PerspectiveCamera(75, 1, 0.1, 1000);
    const nimbusRenderer = new THREE.WebGLRenderer({ alpha: true });
    nimbusRenderer.setSize(60, 60);
    nimbusCloud.appendChild(nimbusRenderer.domElement);

    const nimbusNodes = [];
    const nimbusNodeCount = 3;
    const nimbusGeometry = new THREE.SphereGeometry(0.1, 8, 8);
    for (let i = 0; i < nimbusNodeCount; i++) {
      const material = new THREE.MeshBasicMaterial({
        color: 0x2A6DD1,
        transparent: true,
        opacity: 0.6
      });
      const node = new THREE.Mesh(nimbusGeometry, material);
      node.position.set(
        (Math.random() - 0.5) * 3,
        (Math.random() - 0.5) * 3,
        (Math.random() - 0.5) * 3
      );
      nimbusScene.add(node);
      nimbusNodes.push(node);
    }

    const nimbusLineMaterial = new THREE.LineBasicMaterial({ color: 0x2A6DD1, opacity: 0.3, transparent: true });
    for (let i = 0; i < nimbusNodeCount; i++) {
      for (let j = i + 1; j < nimbusNodeCount; j++) {
        const points = [];
        points.push(nimbusNodes[i].position);
        points.push(nimbusNodes[j].position);
        const geometry = new THREE.BufferGeometry().setFromPoints(points);
        const line = new THREE.Line(geometry, nimbusLineMaterial);
        nimbusScene.add(line);
      }
    }

    nimbusCamera.position.z = 6;

    document.addEventListener('mousemove', (event) => {
      const x = event.clientX - 30;
      const y = event.clientY - 30;
      nimbusCloud.style.left = `${x}px`;
      nimbusCloud.style.top = `${y}px`;
    });

    const animateNimbus = () => {
      requestAnimationFrame(animateNimbus);
      nimbusNodes.forEach((node) => {
        node.position.x += Math.sin(Date.now() * 0.002 + node.position.y) * 0.01;
        node.position.y += Math.cos(Date.now() * 0.002 + node.position.x) * 0.01;
      });
      nimbusRenderer.render(nimbusScene, nimbusCamera);
    };
    animateNimbus();
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
