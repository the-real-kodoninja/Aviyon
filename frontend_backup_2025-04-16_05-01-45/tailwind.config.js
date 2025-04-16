module.exports = {
  content: [
    './resources/views/**/*.blade.php',
    './resources/js/**/*.js',
  ],
  theme: {
    extend: {
      colors: {
        'cyber-dark': '#1A1A1A',
        'cyber-purple': '#A100A1',
        'cyber-neon': '#D400D4',
        'cyber-cyan': '#00F7FF',
        'cyber-white': '#E6E6FA',
      },
      fontFamily: {
        mono: ['Fira Code', 'monospace'],
        sans: ['Inter', 'sans-serif'],
      },
    },
  },
  plugins: [],
}