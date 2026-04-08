<template>
  <div>
    <header class="header">
      <nav>
        <NuxtLink to="/">Home</NuxtLink>
        <NuxtLink to="/about">About</NuxtLink>
      </nav>
    </header>
    <main>
      <slot />
    </main>
  </div>
</template>

<style scoped>
.header {
  padding: 1rem;
  background: #1e293b;
}
.header nav {
  max-width: 1200px;
  margin: 0 auto;
  display: flex;
  gap: 1rem;
}
.header a {
  color: #fff;
  text-decoration: none;
}
main {
  max-width: 1200px;
  margin: 0 auto;
  padding: 2rem 1rem;
}
</style>
