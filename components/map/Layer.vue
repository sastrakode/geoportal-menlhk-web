<script setup lang="ts">
const props = defineProps<{
  geoUrl?: string
  geoData?: string
}>()

const geoStyler: L.StyleFunction = () => ({
  color: "#000000",
  opacity: 1,
  fillColor: "#F6F1D1",
  fillOpacity: 1,
})

const geoJson = ref(undefined)

onMounted(async () => {
  if (props.geoData) {
    geoJson.value = JSON.parse(props.geoData)
  }

  if (props.geoUrl) {
    const response = await fetch(props.geoUrl)
    geoJson.value = await response.json()
  }
})
</script>

<template>
  <LGeoJson :geojson="geoJson" :options-style="geoStyler" />
</template>
