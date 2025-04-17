// assets/js/app.js
import '../css/base.css';
import '../css/components/header.css';
import '../css/components/footer.css';
import '../css/components/sidebar.css';
import '../css/components/shared.css';
import '../css/pages/landing.css';
import '../css/pages/about.css';
import '../css/pages/features.css';
import '../css/pages/auth.css';
import '../css/pages/dashboard.css';

import * as THREE from 'three';
import { initLanding } from './pages/landing.js';
import { initMarketplace } from './pages/dashboard.js';

// Debug: Check if Three.js is loaded
console.log('Three.js version:', THREE.REVISION);

// Check WebGL support
if (!window.WebGLRenderingContext) {
  console.error('WebGL is not supported in this browser!');
} else {
  console.log('WebGL is supported.');
}

// Debug: Confirm Tailwind CSS is loaded
console.log('Tailwind CSS loaded:', typeof window !== 'undefined' && !!document.querySelector('style[id*="tailwind"]'));

// Initialize page-specific JavaScript based on the current page
const path = window.location.pathname;
if (path === '/' || path === '/index.html') {
  initLanding();
}
if (path === '/dashboard/marketplace') {
  initMarketplace();
}

console.log('Aviyon: Web3 Cloud Platform initialized');
