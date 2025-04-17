import * as THREE from 'three';

export function initMarketplace() {
  const marketplaceItem = document.getElementById('marketplace-item-1');
  if (!marketplaceItem) return;

  const scene = new THREE.Scene();
  const camera = new THREE.PerspectiveCamera(75, marketplaceItem.clientWidth / 192, 0.1, 1000);
  const renderer = new THREE.WebGLRenderer({ alpha: true });
  renderer.setSize(marketplaceItem.clientWidth, 192);
  marketplaceItem.appendChild(renderer.domElement);

  const geometry = new THREE.BoxGeometry(1, 1, 1);
  const material = new THREE.MeshBasicMaterial({ color: 0x2A6DD1 });
  const cube = new THREE.Mesh(geometry, material);
  scene.add(cube);

  camera.position.z = 5;

  const animate = () => {
    requestAnimationFrame(animate);
    cube.rotation.x += 0.01;
    cube.rotation.y += 0.01;
    renderer.render(scene, camera);
  };
  animate();
}
