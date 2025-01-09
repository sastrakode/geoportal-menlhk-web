<script setup lang="ts">
const props = defineProps<{
  filename: string
}>()

const geoStyler = (feature: any) => ({
  color: "#000000",
  opacity: 1,
  fillColor: "#F6F1D1",
  fillOpacity: 1,
})

const geoLayer = ref(undefined)

onMounted(async () => {
  const response = await fetch(`/geojson/${props.filename}.geojson`)
  geoLayer.value = await response.json()
})
</script>

<template>
  <LGeoJson :geojson="geoLayer" :options-style="geoStyler" />
</template>
