<template>
  <div class="login-content">
    <label>Login with @odds.team</label>
    <button v-on:click="signIn">Login</button>
  </div>
</template>
<script>
export default {
  name: "login",
  data() {
    return {
      profile: null
    };
  },
  methods: {
    signIn: function() {
      this.$gAuth
        .signIn()
        .then(GoogleUser => {
          window.console.log("user", GoogleUser.getId());
          window.console.log("profile", GoogleUser.getBasicProfile());
          window.console.log("auth", GoogleUser.getAuthResponse());
          this.profile = GoogleUser.getBasicProfile();
          localStorage.setItem("id", this.profile.Eea);
          localStorage.setItem("name", this.profile.ig);
          localStorage.setItem("email", this.profile.U3);
          localStorage.setItem("imgURL", this.profile.Paa);
          window.console.log(localStorage.getItem("id"));
          this.isSignIn = this.$gAuth.isAuthorized;
          this.$router.push("/home");
        })
        .catch(error => {
          window.console.log(error);
        });
    },
    authBackend: function() {}
  }
};
</script>
<style scoped>
.login-content {
  position: absolute;
  width: 40%;
  height: 40%;
  z-index: 15;
  top: 30%;
  left: 30%;
  box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2);
  border-radius: 4px;
}
label {
  display: block;
  text-align: center;
  color: #0e98d5;
  margin-top: 30px;
}
button {
  position: absolute;
  width: 20%;
  bottom: 10%;
  right: 10%;
  border: none;
  color: white;
  padding: 15px 32px;
  text-align: center;
  text-decoration: none;
  background-color: #0e98d5;
  font-size: 16px;
  margin: 4px 2px;
  cursor: pointer;
  border-radius: 4px;
}
</style>
