<script setup lang="ts">
const { baseMaps, geoJsonFiles } = defineProps<{
  baseMaps: { name: string; url: string }[]
  geoJsonFiles: { id: string; filename: string }[]
}>()

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
</script>

<template>
  <nav class="relative w-full flex items-center justify-between z-10">
    <button>
      <a
        href="/interaktif"
        class="group relative w-full flex items-center gap-1.5 rounded-md font-medium text-sm focus:outline-none focus-visible:outline-none dark:focus-visible:outline-none focus-visible:ring-inset focus-visible:ring-2 focus-visible:ring-primary-500 dark:focus-visible:ring-primary-400 disabled:cursor-not-allowed disabled:opacity-75 before:absolute before:inset-x-0 before:inset-y-2 before:inset-px before:rounded-md hover:before:bg-gray-50 dark:hover:before:bg-gray-800/50 after:absolute after:bottom-0 after:inset-x-2.5 after:block after:h-[2px] after:mt-2 text-gray-500 dark:text-gray-400 hover:text-gray-900 dark:hover:text-white"
      >
        <UIcon
          name="i-heroicons-map-solid"
          class="flex-shrink-0 w-5 h-5 relative text-gray-400 dark:text-gray-500 group-hover:text-gray-700 dark:group-hover:text-gray-200"
        />
        <span class="truncate relative">Peta Interaktif</span>
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
              {{ geoJsonFile.filename.replace("_", " ") }}
            </span>
          </template>
        </USelectMenu>
      </li>

      <li>
        <label
          class="group relative w-full flex items-center gap-1.5 rounded-md font-medium text-sm focus:outline-none focus-visible:outline-none dark:focus-visible:outline-none focus-visible:ring-inset focus-visible:ring-2 focus-visible:ring-primary-500 dark:focus-visible:ring-primary-400 disabled:cursor-not-allowed disabled:opacity-75 before:absolute before:inset-x-0 before:inset-y-2 before:inset-px before:rounded-md hover:before:bg-gray-50 dark:hover:before:bg-gray-800/50 after:absolute after:bottom-0 after:inset-x-2.5 after:block after:h-[2px] after:mt-2 text-gray-500 dark:text-gray-400 hover:text-gray-900 dark:hover:text-white"
        >
          <UIcon
            name="i-heroicons-document-plus-solid"
            class="flex-shrink-0 w-5 h-5 relative text-gray-400 dark:text-gray-500 group-hover:text-gray-700 dark:group-hover:text-gray-200"
          />
          <span class="truncate relative">Upload</span>
          <input type="file" @change="handleFileUpload" class="hidden" />
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
