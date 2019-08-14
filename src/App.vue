<template>
  <div id="app">
    <NavBar />
    <CardList />
  </div>
</template>


<script>
import NavBar from "./components/NavBar.vue";
import CardList from "./components/CardList.vue";
export default {
  name: "app",
  components: {
    NavBar,
    CardList
  }
};
</script>


<style>
#app {
  margin: 0;
  padding: 0;
  font-family: "Avenir", Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  color: #2c3e50;
}
.main-color {
  background-color: #1498d5;
}
</style>
