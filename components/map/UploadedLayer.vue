<script setup lang="ts">
const props = defineProps<{
  content: string
}>()

const geoStyler = (feature: any) => ({
  color: "#000000",
  opacity: 1,
  fillColor: "#F6F1D1",
  fillOpacity: 1,
})

const geoLayer = JSON.parse(props.content)
</script>

<template>
  <LGeoJson :geojson="geoLayer" :options-style="geoStyler" />
</template>
