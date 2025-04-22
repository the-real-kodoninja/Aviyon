/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    './templates/**/*.html.twig',
    './assets/js/**/*.js',
  ],
  theme: {
    extend: {
      colors: {
        dark: '#0B0C12',
        'dark-light': '#1A1B23',
        light: '#F5F5F5',
        blue: '#2A6DD1',
        pink: '#FF2D55',
        'cyber-gray': '#B0BEC5',
        'light-space': '#E0F7FA',
      },
      fontFamily: {
        inter: ['Inter', 'sans-serif'],
        'roboto-mono': ['Roboto Mono', 'monospace'],
      },
    },
  },
  plugins: [],
}
