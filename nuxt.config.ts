// https://nuxt.com/docs/api/configuration/nuxt-config
export default defineNuxtConfig({
  devtools: { enabled: true },
  routeRules: {
    "/": {
      redirect: { to: "/interaktif", statusCode: 302 },
    },
  },
  compatibilityDate: "2025-01-08",
  modules: ["@nuxtjs/leaflet", "@nuxt/ui"],
  css: ["~/assets/css/tailwind.css"],
})
