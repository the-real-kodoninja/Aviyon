import '../css/base.css';
import * as THREE from 'three';
import { GLTFLoader } from 'three/examples/jsm/loaders/GLTFLoader.js'; // Added .js extension
import Chart from 'chart.js/auto';
import { initLanding } from './pages/landing';
import { initMarketplace } from './pages/dashboard';
import { initHeader } from './components/header';
import { initFooter } from './components/footer';
import { initSidebar } from './components/sidebar';
import { initAbout } from './pages/about';
import { initAuth } from './pages/auth';
import { initFeatures } from './pages/features';
import { initTicker } from './ticker';

// Expose libraries to global scope for inline scripts
window.THREE = THREE;
window.GLTFLoader = GLTFLoader;
window.Chart = Chart;

// Utility Functions
function initThreeCanvas(canvasId, geometryType = 'box', color = 0x6b48ff, wireframe = true, autoRotate = true) {
    const canvas = document.getElementById(canvasId);
    if (!canvas) return;

    const scene = new THREE.Scene();
    const camera = new THREE.PerspectiveCamera(75, canvas.clientWidth / canvas.clientHeight, 0.1, 1000);
    const renderer = new THREE.WebGLRenderer({ canvas, alpha: true });
    renderer.setSize(canvas.clientWidth, canvas.clientHeight);
    camera.position.z = 5;

    const light = new THREE.DirectionalLight(0xffffff, 0.8);
    light.position.set(0, 1, 1);
    scene.add(light);
    scene.add(new THREE.AmbientLight(0x404040, 0.5));

    let object;
    if (geometryType === 'box') {
        const geometry = new THREE.BoxGeometry(1, 1, 1);
        const material = new THREE.MeshBasicMaterial({ color, wireframe });
        object = new THREE.Mesh(geometry, material);
    } else if (geometryType === 'sphere') {
        const geometry = new THREE.SphereGeometry(1, 32, 32);
        const material = new THREE.MeshBasicMaterial({ color, wireframe });
        object = new THREE.Mesh(geometry, material);
    } else if (geometryType === 'torus') {
        const geometry = new THREE.TorusKnotGeometry(1, 0.3, 100, 16);
        const material = new THREE.MeshBasicMaterial({ color, wireframe });
        object = new THREE.Mesh(geometry, material);
    }

    scene.add(object);

    function animate() {
        requestAnimationFrame(animate);
        if (autoRotate) {
            object.rotation.x += 0.01;
            object.rotation.y += 0.01;
        }
        renderer.render(scene, camera);
    }
    animate();

    window.addEventListener('resize', () => {
        camera.aspect = canvas.clientWidth / canvas.clientHeight;
        camera.updateProjectionMatrix();
        renderer.setSize(canvas.clientWidth, canvas.clientHeight);
    });
}

function initNFTPreview(canvas, modelUrl) {
    const scene = new THREE.Scene();
    const camera = new THREE.PerspectiveCamera(75, canvas.clientWidth / canvas.clientHeight, 0.1, 1000);
    const renderer = new THREE.WebGLRenderer({ canvas, alpha: true });
    renderer.setSize(canvas.clientWidth, canvas.clientHeight);
    camera.position.z = 5;

    const light = new THREE.DirectionalLight(0xffffff, 0.8);
    light.position.set(0, 1, 1);
    scene.add(light);
    scene.add(new THREE.AmbientLight(0x404040, 0.5));

    if (modelUrl) {
        const loader = new GLTFLoader();
        loader.load(modelUrl, (gltf) => {
            scene.add(gltf.scene);
            gltf.scene.scale.set(1, 1, 1);
            gltf.scene.position.set(0, 0, 0);

            const animate = () => {
                requestAnimationFrame(animate);
                gltf.scene.rotation.y += 0.01;
                renderer.render(scene, camera);
            };
            animate();
        }, undefined, (error) => {
            console.error('Error loading GLTF model:', error);
            const geometry = new THREE.BoxGeometry(1, 1, 1);
            const material = new THREE.MeshBasicMaterial({ color: 0x6b48ff });
            const cube = new THREE.Mesh(geometry, material);
            scene.add(cube);

            const animate = () => {
                requestAnimationFrame(animate);
                cube.rotation.y += 0.01;
                renderer.render(scene, camera);
            };
            animate();
        });
    } else {
        const geometry = new THREE.BoxGeometry(1, 1, 1);
        const material = new THREE.MeshBasicMaterial({ color: 0x6b48ff });
        const cube = new THREE.Mesh(geometry, material);
        scene.add(cube);

        const animate = () => {
            requestAnimationFrame(animate);
            cube.rotation.y += 0.01;
            renderer.render(scene, camera);
        };
        animate();
    }
}

function initModal(modalId, openSelector, closeSelector) {
    const modal = document.getElementById(modalId);
    const openButtons = document.querySelectorAll(openSelector);
    const closeButton = document.querySelector(closeSelector);

    openButtons.forEach(btn => {
        btn.addEventListener('click', () => {
            modal.classList.remove('hidden');
        });
    });

    if (closeButton) {
        closeButton.addEventListener('click', () => {
            modal.classList.add('hidden');
        });
    }
}

// Theme Toggle
function initThemeToggle() {
    const themeToggle = document.getElementById('dark-mode-toggle');
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

// Nimbus AI Chat
function initNimbusChat() {
    const chat = document.getElementById('chat-popup');
    const chatClose = document.getElementById('chat-close');
    const chatForm = document.getElementById('chat-form');
    const chatInput = document.getElementById('chat-input');
    const chatMessages = document.querySelector('.chat-messages');
    const typingIndicator = document.querySelector('.typing-indicator');
    const chatToggle = document.getElementById('chat-toggle');

    if (chatToggle && chat) {
        chatToggle.addEventListener('click', () => {
            chat.classList.toggle('hidden');
        });
    }

    if (chatClose && chat) {
        chatClose.addEventListener('click', () => {
            chat.classList.add('hidden');
        });
    }

    if (chatForm && chatInput && chatMessages && typingIndicator) {
        chatForm.addEventListener('submit', (e) => {
            e.preventDefault();
            const message = chatInput.value.trim();
            if (!message) return;

            const userMessage = document.createElement('div');
            userMessage.className = 'message user-message bg-purple-500 text-white p-2 rounded-lg self-end';
            userMessage.textContent = message;
            chatMessages.appendChild(userMessage);
            chatInput.value = '';

            typingIndicator.classList.remove('hidden');
            setTimeout(() => {
                typingIndicator.classList.add('hidden');
                const aiMessage = document.createElement('div');
                aiMessage.className = 'message ai-message bg-gray-700 text-gray-100 p-2 rounded-lg self-start';
                aiMessage.textContent = 'I’m here to help! What would you like to do next?';
                chatMessages.appendChild(aiMessage);
                chatMessages.scrollTop = chatMessages.scrollHeight;
            }, 1000);
        });
    }
}

// Initialize Functions Conditionally Based on Page
document.addEventListener('DOMContentLoaded', () => {
    const path = window.location.pathname;

    if (path === '/' || path === '/landing') {
        initThreeCanvas('bg-canvas', 'torus', 0x8b5cf6);
        initThreeCanvas('three-canvas', 'icosahedron', 0x6b48ff);
        initLanding();
    }
    if (path === '/dashboard/marketplace') {
        document.querySelectorAll('[id^="nft-"]').forEach(canvas => {
            initNFTPreview(canvas, canvas.dataset.model);
        });
        initMarketplace();
    }
    if (path.includes('/dashboard')) {
        initNimbusChat();
    }

    initHeader();
    initFooter();
    initSidebar();
    initThemeToggle();
    initWalletStatus();
    initNotifications();

    // Initialize other page-specific modules
    if (path === '/about') initAbout();
    if (path === '/login' || path === '/signup') initAuth();
    if (path === '/features') initFeatures();
    if (path.includes('/ticker')) initTicker();
});

console.log('Aviyon: Web3 Cloud Platform initialized');
