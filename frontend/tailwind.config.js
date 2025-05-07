/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    './templates/**/*.html.twig',
    './assets/js/**/*.js',
    './assets/js/pages/*.js', // Ensure page-specific JS files are scanned
  ],
  theme: {
    extend: {
      colors: {
        // Existing colors
        dark: '#0B0C12',
        'dark-light': '#1A1B23',
        light: '#F5F5F5',
        blue: '#2A6DD1',
        pink: '#FF2D55',
        'cyber-gray': '#B0BEC5',
        'light-space': '#E0F7FA',
        // Kodoverse trading palette
        'neon-purple': '#8B5CF6', // For Nimbus AI and Whale module
        'neon-green': '#10B981', // For profit indicators
        'neon-red': '#EF4444', // For loss indicators
        'earth-beige': '#F5F5DC', // Earthy tones for Stoploss UI
        'earth-olive': '#808000', // Earthy tones for Stoploss UI
        'earth-brown': '#8B4513', // Earthy tones for Stoploss UI
      },
      fontFamily: {
        inter: ['Inter', 'sans-serif'],
        'roboto-mono': ['Roboto Mono', 'monospace'],
      },
      // Add animations for interactive elements
      animation: {
        'pulse-slow': 'pulse 4s cubic-bezier(0.4, 0, 0.6, 1) infinite',
        'fade-in': 'fadeIn 1s ease-in-out',
      },
      keyframes: {
        fadeIn: {
          '0%': { opacity: '0' },
          '100%': { opacity: '1' },
        },
      },
    },
  },
  plugins: [
    require('tailwindcss-scrollbar'),
  ],
}
