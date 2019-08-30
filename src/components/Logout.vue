<template>
  <div>
    <h3>Logout</h3>
  </div>
</template>

<script>
export default {
  mounted: function() {
    this.$emit("closeNav");
    window.localStorage.clear();
    if (process.env.VUE_APP_PROD) {
      this.$nextTick(() => {
        this.$router.push("/logout");
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