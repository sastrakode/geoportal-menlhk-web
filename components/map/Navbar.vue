<script setup lang="ts">
const { baseMaps } = defineProps<{
  baseMaps: { name: string; url: string }[]
}>()

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
</script>

<template>
  <nav class="relative z-10 flex justify-between items-center w-full">
    <button>
      <a
        href="/interaktif"
        class="after:block relative after:bottom-0 before:absolute after:absolute before:inset-x-0 before:inset-y-2 before:inset-px after:inset-x-2.5 flex items-center gap-1.5 hover:before:bg-gray-50 dark:hover:before:bg-gray-800/50 disabled:opacity-75 after:mt-2 rounded-md before:rounded-md focus-visible:ring-2 focus-visible:ring-primary-500 dark:focus-visible:ring-primary-400 focus-visible:ring-inset w-full after:h-[2px] font-medium text-gray-500 text-sm hover:text-gray-900 dark:hover:text-white dark:text-gray-400 disabled:cursor-not-allowed focus:outline-none focus-visible:outline-none dark:focus-visible:outline-none group"
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
          class="after:block relative after:bottom-0 before:absolute after:absolute before:inset-x-0 before:inset-y-2 before:inset-px after:inset-x-2.5 flex items-center gap-1.5 hover:before:bg-gray-50 dark:hover:before:bg-gray-800/50 disabled:opacity-75 after:mt-2 rounded-md before:rounded-md focus-visible:ring-2 focus-visible:ring-primary-500 dark:focus-visible:ring-primary-400 focus-visible:ring-inset w-full after:h-[2px] font-medium text-gray-500 text-sm hover:text-gray-900 dark:hover:text-white dark:text-gray-400 disabled:cursor-not-allowed focus:outline-none focus-visible:outline-none dark:focus-visible:outline-none group"
        >
          <UIcon
            name="i-heroicons-document-plus-solid"
            class="group-hover:text-gray-700 dark:group-hover:text-gray-200 relative flex-shrink-0 w-5 h-5 text-gray-400 dark:text-gray-500"
          />
          <span class="relative truncate">Upload</span>
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
