<template>
  <div id="app">
    <NavBar />
    <ItemCard />
  </div>
</template>

<script>
// import HelloWorld from './components/HelloWorld.vue'
import NavBar from './components/NavBar.vue'

import ItemCard from './components/ItemCard'
export default {
  name: 'app',
  components: {
    NavBar,
    ItemCard
  }
}
</script>

<style>
#app {
  margin: 0;
  padding: 0;
}
</style>
