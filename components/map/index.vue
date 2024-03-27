<script setup lang="ts">
declare var L: any
const zoom = 7

const baseMaps = [
  {
    name: "Satellite",
    url: "https://mt0.google.com/vt/lyrs=s&hl=en&x={x}&y={y}&z={z}",
  },
  {
    name: "Roads",
    url: "https://mt1.google.com/vt/lyrs=m&x={x}&y={y}&z={z}",
  },
  {
    name: "Hybrid",
    url: "https://mt1.google.com/vt/lyrs=y&x={x}&y={y}&z={z}",
  },
]

const selectedBaseMapUrl = ref(baseMaps[0].url)

const geoJsonFiles = [
  {
    id: "01HSX1Q9W7J3SAS4VS4G2YY54V",
    filename: "BATAS_KABUPATEN_KALIMANTAN_SELATAN",
  },
  {
    id: "01HSX1S10DQ3RZANP31BZD1G61",
    filename: "JALAN_KALIMANTAN_SELATAN",
  },
  {
    id: "01HSX1S6C3WKH7NAYM0KQ6K874",
    filename: "KAWASAN_HUTAN_PROVINSI_KALIMANTAN_SELATAN",
  },
  {
    id: "01HSX1SB0E7A24RZDYW3XJAEE0",
    filename: "BATAS_DESA_KALIMANTAN_SELATAN",
  },
]

const selectedGeoJsonFiles = ref([geoJsonFiles[0]])

const uploadedGeoJsonFiles = ref<string[]>([])

const handleFileUpload = (event: any) => {
  const file = event.target.files[0]
  if (!file) return

  const reader = new FileReader()
  reader.onload = (e: any) => {
    uploadedGeoJsonFiles.value.push(e.target.result)
  }
  reader.readAsText(file)
}

onMounted(async () => {
  L.Marker.prototype.options.icon = L.icon({
    iconUrl: "/marker.svg",
    iconSize: [7, 7],
  })

  L.Marker.prototype.on("click", (e: any) => {
    const data = e.target.feature.properties
    const content = `
    <table>
      <tr>
        <td>ID:</td>
        <td>${data.ID}</td>
      </tr>
      <tr>
        <td>NAMA:</td>
        <td>${data.NAMA}</td>
      </tr>
      <tr>
        <td>PROPINSI:</td>
        <td>${data.PROPINSI}</td>
      </tr>
      <tr>
        <td>STATUS:</td>
        <td>${data.STATUS}</td>
      </tr>
      <tr>
        <td>X_COORD:</td>
        <td>${data.X_COORD}</td>
      </tr>
      <tr>
        <td>Y_COORD:</td>
        <td>${data.Y_COORD}</td>
      </tr>
    </table>
    `

    e.target.bindPopup(content).openPopup().closePopup()
  })
})
</script>

<template>
  <MapNavbar
    :base-maps="baseMaps"
    v-model:selected-base-map-url="selectedBaseMapUrl"
    :geo-json-files="geoJsonFiles"
    v-model:selected-geo-json-files="selectedGeoJsonFiles"
    v-model:handle-file-upload="handleFileUpload"
  />

  <div class="h-[calc(100vh-4em)] w-screen z-0 absolute">
    <LMap ref="map" :zoom="zoom" :center="[-2.731242, 115.41292]">
      <LTileLayer
        :url="selectedBaseMapUrl"
        layer-type="base"
        name="OpenStreetMap"
      />

      <div v-for="geoJsonFile in selectedGeoJsonFiles" :key="geoJsonFile.id">
        <MapPreparedLayer :filename="geoJsonFile.filename" />
      </div>

      <div v-for="(geoJsonFile, id) in uploadedGeoJsonFiles" :key="id">
        <MapUploadedLayer :content="geoJsonFile" />
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
