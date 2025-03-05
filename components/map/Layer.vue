<script setup lang="ts">
const props = defineProps<{
  geoUrl?: string
  geoData?: any
}>()

function getColorByF2023(f2023: string) {
  switch (f2023) {
    case "HPT":
      return "#8AF200" // untuk HPT
    case "HP":
      return "#FFFF00" //  untuk HP
    case "HL":
      return "#02AD00" // untuk HL
    case "HPK":
      return "#FF5EFF" // untuk HPK
    case "KSA":
      return "#AD3FFF" // untuk kawasan konservasi
    case "KSAL":
      return "#AD3FFF" // untuk kawasan konservasi
    case "APL":
      return "#808080" //untuk APL
    case "tubuh air":
    case "Tubuh Air":
      return "#D4FCF7" //untuk Tubuh Air
    case "TAHURA":
      return "#AD3FFF" //untuk kawasan konservasi
    case "CA":
      return "#AD3FFF" //  untuk kawasan konservasi
    case "SM":
      return "#AD3FFF" //  untuk kawasan konservasi
    case "KSA/KPA":
      return "#AD3FFF" // untuk kawasan konservasi
    case "TWA":
      return "#AD3FFF" // untuk kawasan konservasi
    default:
      return "#000000" // untuk nilai yang tidak dikenal
  }
}

function getColorByFungsiII(fungsiII: string) {
  switch (fungsiII) {
    case "1001":
      return "#02AD00" // untuk HL
    case "1002":
      return "#AD3FFF" //  untuk KSA
    case "1003":
      return "#FFFF00" // untuk HP
    case "1004":
      return "#8AF200" //untuk HPT
    case "2001":
      return "#8B0000" // untuk CA
    case "2002":
      return "#B22222" // untuk SM
    case "2003":
      return "#CD5C5C" // untuk TWA
    case "2004":
      return "#800080" //  untuk TB
    case "2005":
      return "#DDA0DD" //  untuk TAHURA
    case "3001":
      return "#808080" //  untuk APL
    case "4001":
      return "#4169E1" //  untuk Tubuh Air
    case "1005":
      return "#FF5EFF" //  untuk HPK
    default:
      return "#D4FCF7" //  untuk nilai yang tidak dikenal
  }
}

function getColorByFungsiJln(fungsiJln: string) {
  switch (fungsiJln.toLowerCase()) {
    case "jalan arteri":
      return "#ff0000" // Merah
    case "jalan kolektor":
      return "#ffa500" // Orange
    case "jalan lokal":
      return "#ffff00" // Kuning
    case "jalan lain":
      return "#808080" // Abu-abu
    default:
      return "#000000" // Hitam
  }
}

const geoStyler: L.StyleFunction = (feature) => {
  const options: {
    color: string
    weight: number
    fillColor: string
    fillOpacity: number
    dashArray?: string
  } = {
    color: "#000000",
    weight: 1,
    fillColor: "#F6F1D1",
    fillOpacity: 0.7,
  }

  if (feature?.properties?.F2023) {
    options.color = getColorByF2023(feature.properties.F2023)
    options.fillColor = options.color
  }

  if (feature?.properties?.FUNGSI_II) {
    options.color = getColorByFungsiII(feature.properties.FUNGSI_II)
    options.fillColor = options.color
  }

  if (feature?.properties?.FUNGSI_JLN) {
    options.color = getColorByFungsiJln(feature.properties.FUNGSI_JLN)
    options.fillColor = options.color
  }

  if (props.geoUrl && feature?.properties?.Luas_Ha) {
    options.weight = 2
    options.fillOpacity = 0
    options.dashArray = "5, 10"
  }

  return options
}

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
