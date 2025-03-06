<script setup lang="ts">
import L from "leaflet"

const { baseMaps } = defineProps<{
  baseMaps: { name: string; url: string }[]
}>()

const map = defineModel("map", {
  required: true,
  type: Object,
})

const zoom = defineModel("zoom", {
  required: true,
  type: Number,
})

const geoJsonFiles = defineModel("geoJsonFiles", {
  required: true,
  type: Array<Object>,
})

const selectedBaseMapUrl = defineModel("selectedBaseMapUrl", {
  required: true,
  type: String,
})

const selectedGeoJsonFiles = defineModel("selectedGeoJsonFiles", {
  required: true,
  type: Array<Object>,
})

const handleFileUpload = defineModel<(payload: Event) => void>(
  "handleFileUpload",
  {
    required: true,
  }
)

let locationMarker: any = null

function handleLocation(position: any) {
  const lat = position.coords.latitude
  const lng = position.coords.longitude
  const accuracy = position.coords.accuracy

  if (locationMarker) {
    map.value.leafletObject.removeLayer(locationMarker)
  }

  locationMarker = L.marker([lat, lng], {
    icon: L.icon({
      iconUrl:
        "https://raw.githubusercontent.com/pointhi/leaflet-color-markers/master/img/marker-icon-2x-blue.png",
      iconSize: [25, 41],
      iconAnchor: [12, 41],
      popupAnchor: [1, -34],
      shadowUrl:
        "https://raw.githubusercontent.com/pointhi/leaflet-color-markers/master/img/marker-shadow.png",
      shadowSize: [41, 41],
    }),
  }).addTo(map.value.leafletObject)

  L.circle([lat, lng], {
    radius: accuracy,
    color: "#4A90E2",
    fillColor: "#4A90E2",
    fillOpacity: 0.2,
  }).addTo(map.value.leafletObject)

  locationMarker
    .bindPopup(
      `
        <div>
          <strong>Lokasi Anda</strong><br>
          Latitude: ${lat.toFixed(6)}<br>
          Longitude: ${lng.toFixed(6)}<br>
          Akurasi: ±${Math.round(accuracy)} meter
        </div>
      `
    )
    .openPopup()

  map.value.leafletObject.setView([lat, lng], zoom.value)
}

function handleLocationError(error: any) {
  let errorMessage
  switch (error.code) {
    case error.PERMISSION_DENIED:
      errorMessage = "Anda menolak akses lokasi."
      break
    case error.POSITION_UNAVAILABLE:
      errorMessage = "Informasi lokasi tidak tersedia."
      break
    case error.TIMEOUT:
      errorMessage = "Waktu permintaan lokasi habis."
      break
    default:
      errorMessage = "Terjadi kesalahan saat mengakses lokasi."
  }

  alert(errorMessage)
}

function handlePrint(e: any) {
  window.print()
}

function handleMyLocation(e: any) {
  navigator.geolocation.getCurrentPosition(handleLocation, handleLocationError)
}
</script>

<template>
  <nav
    id="navbar"
    class="z-10 relative flex justify-between items-center w-full"
  >
    <button>
      <a
        href="/interaktif"
        class="group after:block after:bottom-0 before:absolute after:absolute relative before:inset-x-0 before:inset-y-2 before:inset-px after:inset-x-2.5 flex items-center gap-1.5 hover:before:bg-gray-50 dark:hover:before:bg-gray-800/50 disabled:opacity-75 after:mt-2 rounded-md before:rounded-md focus:outline-none focus-visible:outline-none dark:focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-primary-500 dark:focus-visible:ring-primary-400 focus-visible:ring-inset w-full after:h-[2px] font-medium text-gray-500 hover:text-gray-900 dark:hover:text-white dark:text-gray-400 text-sm disabled:cursor-not-allowed"
      >
        <UIcon
          name="i-heroicons-map-solid"
          class="group-hover:text-gray-700 dark:group-hover:text-gray-200 relative flex-shrink-0 w-5 h-5 text-gray-400 dark:text-gray-500"
        />
        <span class="relative truncate">Peta Interaktif</span>
      </a>
    </button>

    <ul class="flex items-center min-w-0">
      <li class="min-w-0">
        <USelectMenu
          v-model="selectedBaseMapUrl"
          :options="baseMaps"
          value-attribute="url"
          option-attribute="name"
          icon="i-heroicons-squares-2x2-solid"
        >
          <template #label>
            <span>Base</span>
          </template>
        </USelectMenu>
      </li>

      <li class="min-w-0">
        <USelectMenu
          multiple
          v-model="selectedGeoJsonFiles"
          :options="geoJsonFiles"
          icon="i-heroicons-square-3-stack-3d-solid"
        >
          <template #label>
            <span>Layer</span>
          </template>
          <template #option="{ option: geoJsonFile }">
            <span class="truncate">
              {{ geoJsonFile.name.replace("_", " ") }}
            </span>
          </template>
        </USelectMenu>
      </li>

      <li>
        <label
          class="group after:block after:bottom-0 before:absolute after:absolute relative before:inset-x-0 before:inset-y-2 before:inset-px after:inset-x-2.5 flex items-center gap-1.5 hover:before:bg-gray-50 dark:hover:before:bg-gray-800/50 disabled:opacity-75 after:mt-2 rounded-md before:rounded-md focus:outline-none focus-visible:outline-none dark:focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-primary-500 dark:focus-visible:ring-primary-400 focus-visible:ring-inset w-full after:h-[2px] font-medium text-gray-500 hover:text-gray-900 dark:hover:text-white dark:text-gray-400 text-sm disabled:cursor-not-allowed"
        >
          <UIcon
            name="i-heroicons-document-plus-solid"
            class="group-hover:text-gray-700 dark:group-hover:text-gray-200 relative flex-shrink-0 w-5 h-5 text-gray-400 dark:text-gray-500"
          />
          <span class="relative truncate">Upload</span>
          <input type="file" @change="handleFileUpload" class="hidden" />
        </label>
      </li>

      <li>
        <label
          class="group after:block after:bottom-0 before:absolute after:absolute relative before:inset-x-0 before:inset-y-2 before:inset-px after:inset-x-2.5 flex items-center gap-1.5 hover:before:bg-gray-50 dark:hover:before:bg-gray-800/50 disabled:opacity-75 after:mt-2 rounded-md before:rounded-md focus:outline-none focus-visible:outline-none dark:focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-primary-500 dark:focus-visible:ring-primary-400 focus-visible:ring-inset w-full after:h-[2px] font-medium text-gray-500 hover:text-gray-900 dark:hover:text-white dark:text-gray-400 text-sm disabled:cursor-not-allowed"
        >
          <UIcon
            name="i-heroicons-printer-solid"
            class="group-hover:text-gray-700 dark:group-hover:text-gray-200 relative flex-shrink-0 w-5 h-5 text-gray-400 dark:text-gray-500"
          />
          <button class="relative truncate" @click="handlePrint">Print</button>
        </label>
      </li>

      <li>
        <label
          class="group after:block after:bottom-0 before:absolute after:absolute relative before:inset-x-0 before:inset-y-2 before:inset-px after:inset-x-2.5 flex items-center gap-1.5 hover:before:bg-gray-50 dark:hover:before:bg-gray-800/50 disabled:opacity-75 after:mt-2 rounded-md before:rounded-md focus:outline-none focus-visible:outline-none dark:focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-primary-500 dark:focus-visible:ring-primary-400 focus-visible:ring-inset w-full after:h-[2px] font-medium text-gray-500 hover:text-gray-900 dark:hover:text-white dark:text-gray-400 text-sm disabled:cursor-not-allowed"
        >
          <UIcon
            name="i-heroicons-map-pin-solid"
            class="group-hover:text-gray-700 dark:group-hover:text-gray-200 relative flex-shrink-0 w-5 h-5 text-gray-400 dark:text-gray-500"
          />
          <button class="relative truncate" @click="handleMyLocation">
            Lokasi Saya
          </button>
        </label>
      </li>
    </ul>
  </nav>
</template>

<style scoped>
nav {
  display: flex;
  justify-content: space-between;
  padding: 1rem 2rem;
  background: cool;
}

nav ul {
  display: flex;
  list-style: none;
}

nav li {
  padding-left: 1rem;
}
</style>
