<template>
  <nav class="relative w-full flex items-center justify-between">
    <button>
      <a
        href="/interaktif"
        class="group relative w-full flex items-center gap-1.5 rounded-md font-medium text-sm focus:outline-none focus-visible:outline-none dark:focus-visible:outline-none focus-visible:ring-inset focus-visible:ring-2 focus-visible:ring-primary-500 dark:focus-visible:ring-primary-400 disabled:cursor-not-allowed disabled:opacity-75 before:absolute before:inset-x-0 before:inset-y-2 before:inset-px before:rounded-md hover:before:bg-gray-50 dark:hover:before:bg-gray-800/50 after:absolute after:bottom-0 after:inset-x-2.5 after:block after:h-[2px] after:mt-2 text-gray-500 dark:text-gray-400 hover:text-gray-900 dark:hover:text-white"
      >
        <span
          class="i-heroicons-map-solid flex-shrink-0 w-5 h-5 relative text-gray-400 dark:text-gray-500 group-hover:text-gray-700 dark:group-hover:text-gray-200"
        ></span>
        <span class="truncate relative">Peta Interaktif</span>
      </a>
    </button>
    <ul class="flex items-center min-w-0">
      <li class="min-w-0">
        <button
          class="group relative w-full flex items-center gap-1.5 rounded-md font-medium text-sm focus:outline-none focus-visible:outline-none dark:focus-visible:outline-none focus-visible:ring-inset focus-visible:ring-2 focus-visible:ring-primary-500 dark:focus-visible:ring-primary-400 disabled:cursor-not-allowed disabled:opacity-75 before:absolute before:inset-x-0 before:inset-y-2 before:inset-px before:rounded-md hover:before:bg-gray-50 dark:hover:before:bg-gray-800/50 after:absolute after:bottom-0 after:inset-x-2.5 after:block after:h-[2px] after:mt-2 text-gray-500 dark:text-gray-400 hover:text-gray-900 dark:hover:text-white"
        >
          <span
            class="i-heroicons-squares-2x2-solid flex-shrink-0 w-5 h-5 relative text-gray-400 dark:text-gray-500 group-hover:text-gray-700 dark:group-hover:text-gray-200"
          >
          </span>
          <span class="truncate relative">Base</span>
        </button>
      </li>
      <li>
        <button
          class="group relative w-full flex items-center gap-1.5 rounded-md font-medium text-sm focus:outline-none focus-visible:outline-none dark:focus-visible:outline-none focus-visible:ring-inset focus-visible:ring-2 focus-visible:ring-primary-500 dark:focus-visible:ring-primary-400 disabled:cursor-not-allowed disabled:opacity-75 before:absolute before:inset-x-0 before:inset-y-2 before:inset-px before:rounded-md hover:before:bg-gray-50 dark:hover:before:bg-gray-800/50 after:absolute after:bottom-0 after:inset-x-2.5 after:block after:h-[2px] after:mt-2 text-gray-500 dark:text-gray-400 hover:text-gray-900 dark:hover:text-white"
        >
          <span
            class="i-heroicons-square-3-stack-3d-solid flex-shrink-0 w-5 h-5 relative text-gray-400 dark:text-gray-500 group-hover:text-gray-700 dark:group-hover:text-gray-200"
          ></span>
          <span class="truncate relative">Layer</span>
        </button>
      </li>
      <li>
        <button
          class="group relative w-full flex items-center gap-1.5 rounded-md font-medium text-sm focus:outline-none focus-visible:outline-none dark:focus-visible:outline-none focus-visible:ring-inset focus-visible:ring-2 focus-visible:ring-primary-500 dark:focus-visible:ring-primary-400 disabled:cursor-not-allowed disabled:opacity-75 before:absolute before:inset-x-0 before:inset-y-2 before:inset-px before:rounded-md hover:before:bg-gray-50 dark:hover:before:bg-gray-800/50 after:absolute after:bottom-0 after:inset-x-2.5 after:block after:h-[2px] after:mt-2 text-gray-500 dark:text-gray-400 hover:text-gray-900 dark:hover:text-white"
        >
          <span
            class="i-heroicons-document-plus-solid flex-shrink-0 w-5 h-5 relative text-gray-400 dark:text-gray-500 group-hover:text-gray-700 dark:group-hover:text-gray-200"
          ></span>
          <span class="truncate relative">Upload</span>
        </button>
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
