/** @type {import('tailwindcss').Config} */
const withMT = require("@material-tailwind/react/utils/withMT");

module.exports = withMT({
  content: ["./src/**/*.{html,js,astro}",
  'node_modules/preline/dist/*.js',
  "node_modules/@material-tailwind/react/components/**/*.{js,ts,jsx,tsx}",
  "node_modules/@material-tailwind/react/theme/components/**/*.{js,ts,jsx,tsx}"
  ],
  theme: {
    extend: {},
  },
  plugins: [
    require('preline/plugin'),
    require("daisyui"),
    require('@tailwindcss/forms')({
      strategy: 'class', // only generate classes
    }),
  ],
  daisyui: {
    themes: [
      {
        mytheme: {
          "primary": "#E83C3C",
          "primary-focus":"#d81919",
          "secondary":"#ec5f5f",
          "base-100":"#fff"
        }
      },
      "light"]
  },
  safelist:[
    "bg-gray-200"
  ]
  // important: true,
})

