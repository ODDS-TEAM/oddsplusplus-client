<template>
  <h3>{{msg}}</h3>
</template>

<script>
export default {
  data() {
    return {
      msg: "Please wait while redirecting...",
      responseBody: null
    };
  },
  mounted: function() {
    this.$emit("closeNav");
    this.getUserinfo();
  },
  methods: {
    getUserinfo: function() {
    //   this.$http.get(process.env.VUE_APP_API + "/callback").then(
    //     response => {
    //       this.responseBody = response.body;
    //       window.console.log(response);
    //       localStorage.clear();
    //       this.$nextTick(() => {
    //         localStorage.setItem("userId", this.responseBody.id);
    //         localStorage.setItem("name", this.responseBody.name);
    //         localStorage.setItem("email", this.responseBody.email);
    //         localStorage.setItem("imgURL", this.responseBody.imgURL);
    //       });
          this.$emit("refreshNav");
          this.$router.push("/home");
    //     }
    //   );
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