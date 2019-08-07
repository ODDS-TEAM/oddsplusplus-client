<template>
  <div id="app">
    <NavBar />
    <add-product />
    <CardList />
  </div>
</template>


<script>
// import HelloWorld from './components/HelloWorld.vue'
import NavBar from './components/NavBar.vue'
import CardList from './components/CardList.vue'
// import AddProduct from './components/AddProduct.vue'

// import Card from './components/Card.vue'
export default {
  name: 'app',
  components: {
    NavBar,
    CardList
  }
}
</script>


<style>
#app {
  margin: 0;
  padding: 0;
  font-family: 'Avenir', Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  color: #2c3e50;
}
</style>
