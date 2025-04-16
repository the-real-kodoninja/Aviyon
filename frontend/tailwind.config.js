/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    './templates/**/*.{html,twig}',
    './assets/js/**/*.js'
  ],
  theme: {
    extend: {
      colors: {
        // Futuristic Dark Theme
        'neon-blue': '#00D4FF',
        'neon-magenta': '#FF00E5',
        'dark-space': '#0A0E1A',
        'light-space': '#E0F7FA',
        'cyber-gray': '#B0BEC5',
      },
      fontFamily: {
        orbitron: ['Orbitron', 'sans-serif'],
        inter: ['Inter', 'sans-serif'],
      },
      animation: {
        'pulse-slow': 'pulse 3s cubic-bezier(0.4, 0, 0.6, 1) infinite',
        'typewriter': 'typewriter 3s steps(40) 1s 1 normal both',
      },
      keyframes: {
        pulse: {
          '0%, 100%': { opacity: 1 },
          '50%': { opacity: 0.7 },
        },
        typewriter: {
          '0%': { width: '0%' },
          '100%': { width: '100%' },
        },
      },
    },
  },
  darkMode: 'class',
  plugins: [],
};
