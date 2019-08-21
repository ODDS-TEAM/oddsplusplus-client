<template>
  <div id="app">
    <NavBar @addEvent="refreshCard" />

    <div class="body">
      <router-view @refreshMyItem="refreshCard" v-if="renderComponent" />
    </div>
  </div>
</template>


<script>
import NavBar from "./components/NavBar.vue";
export default {
  name: "app",
  components: {
    NavBar
  },
  mounted: function() {
    this.$http.get(process.env.VUE_APP_API + "/users/Cheese").then(response => {
      this.user = response.body;
      localStorage.setItem("userId", this.user.id);
    });
  },
  data() {
    return {
      renderComponent: true
    };
  },
  methods: {
    refreshCard() {
      this.renderComponent = false;

      this.$nextTick(() => {
        // Add the component back in
        this.renderComponent = true;
      });
    }
  }
};
</script>


<style>
ul {
  padding: 0;
}
h3 {
  color: #515151;
  margin-bottom: 5px;
  font-size: 18px;
}
h4 {
  margin: 0;
  color: #727272;
  font-weight: 500;
  font-size: 12px;
}
h1 {
  color: #515151;
  font-weight: 300;
  padding-top: 15px;
  margin: 0;
  font-size: 30px;
  font-weight: 300;
}
h5 {
  margin: 15px 0;
}
li {
  list-style-type: none;
}
.body {
  margin-top: 63px;
  padding: 0;
}
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
* {
  box-sizing: border-box;
}
.card {
  border-radius: 10px;
  box-shadow: 0 0 15px 0 rgba(0, 0, 0, 0.2);
  transition: 0.3s;
  width: 80%;
  margin: 15px auto;
}
.card:hover {
  box-shadow: 0 0 15px 0 rgba(0, 0, 0, 0.5);
}
.row::after {
  content: "";
  clear: both;
  display: table;
}

[class*="col-"] {
  float: left;
  padding: 0;
}

/* For mobile phones: */
[class*="col-"] {
  width: 100%;
}
@media only screen and (min-width: 600px) {
  /* For tablets: */
  .col-s-1 {
    width: 8.33%;
  }
  .col-s-2 {
    width: 16.66%;
  }
  .col-s-3 {
    width: 25%;
  }
  .col-s-4 {
    width: 33.33%;
  }
  .col-s-5 {
    width: 41.66%;
  }
  .col-s-6 {
    width: 50%;
  }
  .col-s-7 {
    width: 58.33%;
  }
  .col-s-8 {
    width: 66.66%;
  }
  .col-s-9 {
    width: 75%;
  }
  .col-s-10 {
    width: 83.33%;
  }
  .col-s-11 {
    width: 91.66%;
  }
  .col-s-12 {
    width: 100%;
  }
}

@media only screen and (min-width: 768px) {
  /* For desktop: */
  .img-item {
    position: relative;
    margin: auto auto;
    max-width: 200px;
    max-height: 240px;
  }
  ul {
    margin-top: 94px;
  }
  .card {
    width: 700px;
    margin: 25px auto;
  }
  .body {
    margin-top: 64px;
  }
  .col-1 {
    width: 8.33%;
  }
  .col-2 {
    width: 16.66%;
  }
  .col-3 {
    width: 25%;
  }
  .col-4 {
    width: 33.33%;
  }
  .col-5 {
    width: 41.66%;
  }
  .col-6 {
    width: 50%;
  }
  .col-7 {
    width: 58.33%;
  }
  .col-8 {
    width: 66.66%;
  }
  .col-9 {
    width: 75%;
  }
  .col-10 {
    width: 83.33%;
  }
  .col-11 {
    width: 91.66%;
  }
  .col-12 {
    width: 100%;
  }
}
</style>
