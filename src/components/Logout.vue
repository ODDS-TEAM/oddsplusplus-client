<template>
  <div>
    <h3>Your Sign Out Successful</h3>
  </div>
</template>

<script>
export default {
  mounted: function() {
    window.localStorage.clear();
    setTimeout(()=> {
          this.$router.push("/")
    },5000)
    // if (process.env.VUE_APsP_PROD) {
    //   this.$nextTick(() => {
    //     this.$router.push("/logout");
    //   });
    // }
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