const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  content: [
    './public/*.html',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*',
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: ['Inter var', ...defaultTheme.fontFamily.sans],
      },
      colors: {
        transparent: 'transparent',
          current: 'currentColor',
          'dark-violet': '#00031A',
          'dark-gray': '#636363',
          gray: '#C4C4C4',
          'light-gray': '#E0E0E0',
          background: '#F4F7FA',
          'full-black': '#000000',
          focus: '#1D76EF',
          'tag-restored': '#559F21',
          hover: '#446CBC',
          'active-outline': '#9EBBF3',
          'status-error': '#D42F1A',
          links: '#076CE0',
          active: '#254A96',
      },
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/aspect-ratio'),
    require('@tailwindcss/typography'),
    require('@tailwindcss/container-queries'),
  ]
}
