<script setup lang="ts">
const zoom = 7

const geoJsonFiles = ref<{ filename: string; checked: boolean }[]>([
  { filename: "BATAS_KABUPATEN_KALIMANTAN_SELATAN", checked: true },
  { filename: "JALAN_KALIMANTAN_SELATAN", checked: false },
  { filename: "KAWASAN_HUTAN_PROVINSI_KALIMANTAN_SELATAN", checked: false },
  { filename: "BATAS_DESA_KALIMANTAN_SELATAN", checked: false },
])
</script>

<template>
  <LMap ref="map" :zoom="zoom" :center="[-2.731242, 115.41292]">
    <LTileLayer
      url="https://mt0.google.com/vt/lyrs=s&hl=en&x={x}&y={y}&z={z}"
      attribution='&amp;copy; <a href="https://www.openstreetmap.org/">OpenStreetMap</a> contributors'
      layer-type="base"
      name="OpenStreetMap"
    />

    <div v-for="(geoJsonFile, index) in geoJsonFiles" :key="index">
      <MapPreparedLayer
        v-if="geoJsonFile.checked"
        :filename="geoJsonFile.filename"
      />
    </div>
  </LMap>
</template>

<style>
body {
  margin: 0;
}
</style>
