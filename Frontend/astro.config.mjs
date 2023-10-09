import { defineConfig } from 'astro/config';
import tailwind from "@astrojs/tailwind";
//import alpine from '@astrojs/alpinejs';
import react from "@astrojs/react";
// import compress from "astro-compress";


// https://astro.build/config
export default defineConfig({
  // base: '.',
  build: {
    assetsPrefix: './'
    // inlineStylesheets: 'always'
  },

  compressHTML: true,
  integrations: [tailwind()
  // UnoCSS({injectReset: true})
  , react()
  //  compress(),
]
});
