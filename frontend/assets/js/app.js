import '../css/base.css';
import * as THREE from 'three';
import { GLTFLoader } from 'three/examples/jsm/loaders/GLTFLoader.js';
import { initLanding } from './pages/landing.js';
import { initMarketplace } from './pages/dashboard.js';

// Debug
console.log('Three.js version:', THREE.REVISION);
if (!window.WebGLRenderingContext) {
    console.error('WebGL is not supported!');
} else {
    console.log('WebGL is supported.');
}

// Three.js Background
function initBackground() {
    const canvas = document.getElementById('bg-canvas');
    if (!canvas) return;

    const scene = new THREE.Scene();
    const camera = new THREE.PerspectiveCamera(75, window.innerWidth / window.innerHeight, 0.1, 1000);
    const renderer = new THREE.WebGLRenderer({ canvas, alpha: true });
    renderer.setSize(window.innerWidth, window.innerHeight);
    camera.position.z = 5;

    const geometry = new THREE.TorusKnotGeometry(1, 0.3, 100, 16);
    const material = new THREE.MeshBasicMaterial({ color: 0x8b5cf6, wireframe: true });
    const torusKnot = new THREE.Mesh(geometry, material);
    scene.add(torusKnot);

    function animate() {
        requestAnimationFrame(animate);
        torusKnot.rotation.x += 0.01;
        torusKnot.rotation.y += 0.01;
        renderer.render(scene, camera);
    }
    animate();

    window.addEventListener('resize', () => {
        camera.aspect = window.innerWidth / window.innerHeight;
        camera.updateProjectionMatrix();
        renderer.setSize(window.innerWidth, window.innerHeight);
    });
}

// Three.js Hero Animation
function initHeroCanvas() {
    const canvas = document.getElementById('three-canvas');
    if (!canvas) return;

    const scene = new THREE.Scene();
    const camera = new THREE.PerspectiveCamera(75, canvas.clientWidth / canvas.clientHeight, 0.1, 1000);
    const renderer = new THREE.WebGLRenderer({ canvas, alpha: true });
    renderer.setSize(canvas.clientWidth, canvas.clientHeight);
    camera.position.z = 5;

    const geometry = new THREE.IcosahedronGeometry(1, 1);
    const material = new THREE.MeshBasicMaterial({ color: 0x6b48ff, wireframe: true });
    const icosahedron = new THREE.Mesh(geometry, material);
    scene.add(icosahedron);

    function animate() {
        requestAnimationFrame(animate);
        icosahedron.rotation.x += 0.01;
        icosahedron.rotation.y += 0.01;
        renderer.render(scene, camera);
    }
    animate();
}

// Nimbus AI Popup Animation
function initNimbusPopup() {
    const canvas = document.getElementById('nimbus-cloud');
    if (!canvas) return;

    const scene = new THREE.Scene();
    const camera = new THREE.PerspectiveCamera(75, canvas.clientWidth / canvas.clientHeight, 0.1, 1000);
    const renderer = new THREE.WebGLRenderer({ canvas, alpha: true });
    renderer.setSize(canvas.clientWidth, canvas.clientHeight);
    camera.position.z = 5;

    const geometry = new THREE.SphereGeometry(1, 32, 32);
    const material = new THREE.MeshBasicMaterial({ color: 0x8b5cf6, wireframe: true });
    const sphere = new THREE.Mesh(geometry, material);
    scene.add(sphere);

    function animate() {
        requestAnimationFrame(animate);
        sphere.rotation.y += 0.02;
        renderer.render(scene, camera);
    }
    animate();
}

// 3D NFT Previews with GLTFLoader
function initNFTPreviews() {
    document.querySelectorAll('[id^="nft-"]').forEach(canvas => {
        const scene = new THREE.Scene();
        const camera = new THREE.PerspectiveCamera(75, canvas.clientWidth / canvas.clientHeight, 0.1, 1000);
        const renderer = new THREE.WebGLRenderer({ canvas, alpha: true });
        renderer.setSize(canvas.clientWidth, canvas.clientHeight);
        camera.position.z = 5;

        const light = new THREE.DirectionalLight(0xffffff, 0.8);
        light.position.set(0, 1, 1);
        scene.add(light);

        const modelUrl = canvas.dataset.model;
        if (modelUrl) {
            const loader = new GLTFLoader();
            loader.load(modelUrl, (gltf) => {
                scene.add(gltf.scene);
                gltf.scene.scale.set(1, 1, 1);
                gltf.scene.position.set(0, 0, 0);
            }, undefined, (error) => {
                console.error('Error loading GLTF model:', error);
                // Fallback to cube
                const geometry = new THREE.BoxGeometry(1, 1, 1);
                const material = new THREE.MeshBasicMaterial({ color: 0x6b48ff, wireframe: true });
                const cube = new THREE.Mesh(geometry, material);
                scene.add(cube);
            });
        } else {
            const geometry = new THREE.BoxGeometry(1, 1, 1);
            const material = new THREE.MeshBasicMaterial({ color: 0x6b48ff, wireframe: true });
            const cube = new THREE.Mesh(geometry, material);
            scene.add(cube);
        }

        function animate() {
            requestAnimationFrame(animate);
            renderer.render(scene, camera);
        }
        animate();
    });
}

// Theme Toggle
function initThemeToggle() {
    const themeToggle = document.querySelector('.theme-toggle');
    if (themeToggle) {
        themeToggle.addEventListener('click', () => {
            document.documentElement.dataset.theme = document.documentElement.dataset.theme === 'dark' ? 'light' : 'dark';
        });
    }
}

// Wallet Integration
function initWalletStatus() {
    const walletStatus = document.getElementById('wallet-status');
    const walletConnect = document.getElementById('wallet-connect');
    if (walletStatus) {
        walletStatus.addEventListener('click', async () => {
            if (window.ethereum) {
                try {
                    await window.ethereum.request({ method: 'eth_requestAccounts' });
                    walletStatus.textContent = 'Wallet Connected';
                } catch (error) {
                    console.error('Wallet connection failed:', error);
                }
            } else {
                alert('Please install MetaMask or an ICP-compatible wallet.');
            }
        });
    }
    if (walletConnect) {
        walletConnect.addEventListener('click', async () => {
            if (window.ethereum) {
                try {
                    await window.ethereum.request({ method: 'eth_requestAccounts' });
                    alert('Wallet connected!');
                } catch (error) {
                    console.error('Wallet connection failed:', error);
                }
            } else {
                alert('Please install MetaMask or an ICP-compatible wallet.');
            }
        });
    }
}

// Notifications
function initNotifications() {
    const notificationBell = document.getElementById('notification-bell');
    const notificationCount = document.getElementById('notification-count');
    if (notificationBell && notificationCount) {
        notificationBell.addEventListener('click', () => {
            notificationCount.classList.toggle('hidden');
            notificationCount.textContent = parseInt(notificationCount.textContent || 0) + 1;
        });
    }
}

// Nimbus AI Suggestions
function initNimbusTrigger() {
    const nimbusTrigger = document.getElementById('nimbus-trigger');
    const nimbusPopup = document.getElementById('nimbus-popup');
    const nimbusClose = document.getElementById('nimbus-close');
    const nimbusSubmit = document.getElementById('nimbus-submit');
    const nimbusQuery = document.getElementById('nimbus-query');
    const nimbusSuggestions = document.getElementById('nimbus-suggestions');
    if (nimbusTrigger && nimbusPopup && nimbusClose && nimbusSubmit && nimbusQuery && nimbusSuggestions) {
        nimbusTrigger.addEventListener('click', () => nimbusPopup.classList.toggle('hidden'));
        nimbusClose.addEventListener('click', () => nimbusPopup.classList.add('hidden'));
        nimbusSubmit.addEventListener('click', () => {
            const query = nimbusQuery.value;
            window.location.href = `/search?q=${encodeURIComponent(query)}`;
        });
        nimbusQuery.addEventListener('input', () => {
            const query = nimbusQuery.value.toLowerCase();
            const suggestions = [
                '@kodoninja', '@kodonomad', '#Web3', '#DeFi', '#AI',
                'Deploy smart contract', 'Swap tokens', 'Search NFTs'
            ].filter(s => s.toLowerCase().includes(query));
            nimbusSuggestions.innerHTML = suggestions.map(s => `<li class="cursor-pointer hover:text-accent">${s}</li>`).join('');
            nimbusSuggestions.querySelectorAll('li').forEach(item => {
                item.addEventListener('click', () => {
                    nimbusQuery.value = item.textContent;
                    nimbusSuggestions.innerHTML = '';
                });
            });
        });
    }
}

// Infinite Scroll
function initInfiniteScroll() {
    const loadMore = document.getElementById('load-more');
    if (loadMore) {
        loadMore.addEventListener('click', async () => {
            try {
                const response = await fetch('/landing?page=' + (parseInt(loadMore.dataset.page || 1) + 1));
                const data = await response.json();
                console.log('Load more posts:', data);
                loadMore.dataset.page = parseInt(loadMore.dataset.page || 1) + 1;
            } catch (error) {
                console.error('Error loading posts:', error);
            }
        });
    }
}

// Page-Specific Initialization
const path = window.location.pathname;
if (path === '/' || path === '/index.html') {
    initLanding();
}
if (path === '/dashboard/marketplace') {
    initMarketplace();
}

// Social Interactions
document.querySelectorAll('.like-btn').forEach(btn => {
    btn.addEventListener('click', async (e) => {
        e.preventDefault();
        const postId = btn.getAttribute('data-post-id');
        const count = btn.querySelector('span');
        try {
            const response = await fetch('/post/like', {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: `post_id=${postId}`,
            });
            const data = await response.json();
            count.textContent = data.likes;
        } catch (error) {
            console.error('Error liking post:', error);
        }
    });
});

document.querySelectorAll('.comment-toggle').forEach(btn => {
    btn.addEventListener('click', () => {
        const form = btn.closest('.post-card').querySelector('.comment-form');
        form.classList.toggle('hidden');
    });
});

// Initialize
document.addEventListener('DOMContentLoaded', () => {
    initBackground();
    initHeroCanvas();
    initNimbusPopup();
    initNFTPreviews();
    initThemeToggle();
    initWalletStatus();
    initNotifications();
    initNimbusTrigger();
    initInfiniteScroll();
    initLanding();
    initMarketplace();
});

console.log('Aviyon: Web3 Cloud Platform initialized');
