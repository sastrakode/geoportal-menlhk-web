<script setup lang="ts">
const zoom = 7
const basemap = ref("https://mt0.google.com/vt/lyrs=s&hl=en&x={x}&y={y}&z={z}")

const geoJsonFiles = ref<{ filename: string; checked: boolean }[]>([
  { filename: "BATAS_KABUPATEN_KALIMANTAN_SELATAN", checked: true },
  { filename: "JALAN_KALIMANTAN_SELATAN", checked: false },
  { filename: "KAWASAN_HUTAN_PROVINSI_KALIMANTAN_SELATAN", checked: false },
  { filename: "BATAS_DESA_KALIMANTAN_SELATAN", checked: false },
])

const navLinks = [
  [
    {
      label: "Peta Interaktif",
      icon: "i-heroicons-map-solid",
    },
  ],
  [
    {
      label: "Base",
      icon: "i-heroicons-squares-2x2-solid",
    },
    {
      label: "Layer",
      icon: "i-heroicons-square-3-stack-3d-solid",
    },
    {
      label: "Upload",
      icon: "i-heroicons-document-plus-solid",
    },
  ],
]
</script>

<template>
  <UHorizontalNavigation :links="navLinks" />

  <div class="h-[calc(100vh-3em)] w-screen">
    <LMap ref="map" :zoom="zoom" :center="[-2.731242, 115.41292]">
      <LTileLayer :url="basemap" layer-type="base" name="OpenStreetMap" />

      <div v-for="(geoJsonFile, index) in geoJsonFiles" :key="index">
        <MapPreparedLayer
          v-if="geoJsonFile.checked"
          :filename="geoJsonFile.filename"
        />
      </div>
    </LMap>
  </div>
</template>

<style>
body {
  margin: 0;
}

.leaflet-control-attribution.leaflet-control {
  display: none;
}

html
  body
  .leaflet-control-container
  .leaflet-top
  .leaflet-control-zoom
  a.leaflet-control-zoom-in {
  background-color: black;
  color: white;
}

html
  body
  .leaflet-control-container
  .leaflet-top
  .leaflet-control-zoom
  a.leaflet-control-zoom-out {
  background-color: black;
  color: white;
}
</style>
