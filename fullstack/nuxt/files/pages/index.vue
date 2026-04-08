<template>
  <div>
    <h1>Welcome to {{PROJECT_NAME}}</h1>
    <p>Built with Nuxt 3.</p>
    <p v-if="data">API says: {{ data.message }}</p>
  </div>
</template>

<script setup lang="ts">
const { data } = await useFetch("/api/hello");
</script>
