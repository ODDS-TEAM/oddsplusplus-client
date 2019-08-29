<template>
  <h3>Please wait while redirecting...</h3>
</template>

<script>
export default {
  mounted: function() {
    this.$emit("closeNav");
  },
  methods: {
    getUserinfo: function() {
      this.$http.get(process.env.VUE_APP_API + "/callback").then(response => {
        window.console.log(response);
        localStorage.setItem("userId", response.id);
        localStorage.setItem("name", response.name);
        localStorage.setItem("email", response.email);
        localStorage.setItem("imgURL", response.imgURL);
        this.$router.push("/home");
        this.$emit("refreshNav");
      });
    }
  }
};
</script>

<style scoped>
h3 {
  width: 100%;
  text-align: center;
  position: fixed;
  transform: translate(-50%, -50%);
  top: 45%;
  left: 50%;
  font-size: 21px;
}
</style>