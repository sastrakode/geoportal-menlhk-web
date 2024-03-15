<script setup lang="ts">
const props = defineProps<{
  filename: string
}>()

const geoStyler = (feature: any) => ({
  opacity: feature.properties.code / 100000,
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
