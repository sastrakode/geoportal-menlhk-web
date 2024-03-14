// https://nuxt.com/docs/api/configuration/nuxt-config
export default defineNuxtConfig({
  devtools: { enabled: true },
  routeRules: {
    "/": {
      redirect: { to: "/interaktif", statusCode: 302 },
    },
  },
  modules: ["nuxt3-leaflet"],
})
