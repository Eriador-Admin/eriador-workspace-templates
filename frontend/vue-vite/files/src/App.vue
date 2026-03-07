<template>
  <nav>
    <router-link to="/">Home</router-link> |
    <router-link to="/about">About</router-link>
  </nav>
  <router-view />
</template>

<script setup>
</script>

<style>
nav { padding: 1rem; background: #f5f5f5; }
nav a { margin-right: 1rem; color: #42b883; }
</style>
