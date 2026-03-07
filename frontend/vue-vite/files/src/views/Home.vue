<template>
  <div style="padding: 2rem">
    <h1>Home</h1>
    <p>Your Vue 3 + Vite app is ready.</p>
    <p>Count: {{ counter.count }} (Double: {{ counter.doubleCount }})</p>
    <button @click="counter.increment()">Increment</button>
    <button @click="counter.decrement()" style="margin-left: 0.5rem">Decrement</button>
  </div>
</template>

<script setup>
import { useCounterStore } from '../stores/counter';

const counter = useCounterStore();
</script>
