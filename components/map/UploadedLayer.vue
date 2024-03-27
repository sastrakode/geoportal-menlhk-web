<script setup lang="ts">
const props = defineProps<{
  content: string
}>()

const geoStyler = (feature: any) => ({
  opacity: feature.properties.code / 100000,
})

const geoLayer = JSON.parse(props.content)
</script>

<template>
  <LGeoJson :geojson="geoLayer" :options-style="geoStyler" />
</template>
