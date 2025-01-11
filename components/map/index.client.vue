<script setup lang="ts">
import L, { type LeafletMouseEvent } from "leaflet"

const zoom = 7

function generateId() {
  return crypto.randomUUID()
}

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

const geoJsonFiles = ref<
  {
    id: string
    name: string
    url?: string
    data?: string
  }[]
>([
  {
    id: generateId(),
    name: "BATAS KABUPATEN KALIMANTAN SELATAN",
    url: "/geojson/BATAS_KABUPATEN_KALIMANTAN_SELATAN.geojson",
  },
  {
    id: generateId(),
    name: "JALAN KALIMANTAN SELATAN",
    url: "/geojson/JALAN_KALIMANTAN_SELATAN.geojson",
  },
  {
    id: generateId(),
    name: "KAWASAN HUTAN PROVINSI KALIMANTAN SELATAN",
    url: "/geojson/KAWASAN_HUTAN_PROVINSI_KALIMANTAN_SELATAN.geojson",
  },
  {
    id: generateId(),
    name: "BATAS DESA KALIMANTAN SELATAN",
    url: "/geojson/BATAS_DESA_KALIMANTAN_SELATAN.geojson",
  },
])

const selectedGeoJsonFiles = ref([geoJsonFiles.value[0]])

function handleFileUpload(event: Event) {
  const file = (event.target as HTMLInputElement).files?.[0]
  if (!file) return

  const reader = new FileReader()
  reader.onload = (e: ProgressEvent<FileReader>) => {
    geoJsonFiles.value.push({
      id: generateId(),
      name: file.name,
      data: e.target?.result as string,
    })

    selectedGeoJsonFiles.value.push(
      geoJsonFiles.value[geoJsonFiles.value.length - 1]
    )
  }

  reader.readAsText(file)
}

onMounted(async () => {
  L.Layer.prototype.on("click", (e: LeafletMouseEvent) => {
    if (!e.target.feature) return

    const properties = e.target.feature.properties
    const content = `
      <div class="max-h-[300px] overflow-y-auto" style="scrollbar-width: thin; scrollbar-color: #4B5563 #1F2937;">
        <table class="border-collapse bg-gray-900 w-full min-w-[200px] max-w-[400px] text-white">
        ${Object.entries(properties)
          .map(
            ([key, value]) => `
            <tr class="border-gray-700 border-b">
            <td class="px-2 py-1 font-semibold break-words">${key}:</td>
            <td class="px-2 py-1 break-words">${value ?? ""}</td>
            </tr>`
          )
          .join("")}
        </table>
      </div>
      <style>
      .leaflet-popup-content-wrapper {
      background: #1F2937;
      color: white;
      }
      .leaflet-popup-tip {
      background: #1F2937;
      }
      ::-webkit-scrollbar {
      width: 8px;
      }
      ::-webkit-scrollbar-track {
      background: #1F2937;
      }
      ::-webkit-scrollbar-thumb {
      background: #4B5563;
      border-radius: 4px;
      }
      ::-webkit-scrollbar-thumb:hover {
      background: #6B7280;
      }
      </style>
    `

    e.target.bindPopup(content).openPopup().closePopup()
  })
})
</script>

<template>
  <MapNavbar
    :base-maps="baseMaps"
    v-model:selected-base-map-url="selectedBaseMapUrl"
    v-model:geo-json-files="geoJsonFiles"
    v-model:selected-geo-json-files="selectedGeoJsonFiles"
    v-model:handle-file-upload="handleFileUpload"
  />

  <div class="z-0 absolute w-screen h-[calc(100vh-4em)]">
    <LMap ref="map" :zoom="zoom" :center="[-2.731242, 115.41292]">
      <LTileLayer
        :url="selectedBaseMapUrl"
        layer-type="base"
        name="OpenStreetMap"
      />

      <div v-for="geoJsonFile in selectedGeoJsonFiles" :key="geoJsonFile.id">
        <MapLayer :geo-url="geoJsonFile.url" :geo-data="geoJsonFile.data" />
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

.leaflet-control-zoom.leaflet-bar.leaflet-control {
  border: none;
}

.leaflet-control-zoom a {
  background-color: black;
  color: white;
  border: none;
}

.leaflet-control-zoom a:hover {
  background-color: #18181b;
}

.leaflet-control-zoom a:first-child {
  border-top-left-radius: 8px !important;
  border-top-right-radius: 8px !important;
}

.leaflet-control-zoom a:last-child {
  border-bottom-left-radius: 8px !important;
  border-bottom-right-radius: 8px !important;
}
</style>
