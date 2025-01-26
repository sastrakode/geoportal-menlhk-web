<script setup lang="ts">
const props = defineProps<{
  geoUrl?: string
  geoData?: any
}>()

const geoStyler: L.StyleFunction = () => ({
  color: "#000000",
  weight: 1,
  fillColor: "#F6F1D1",
  fillOpacity: 0.7,
})

const geoJson = ref(undefined)

onMounted(async () => {
  if (props.geoData) {
    geoJson.value = props.geoData
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
