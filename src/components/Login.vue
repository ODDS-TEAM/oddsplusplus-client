<template>
  <div class="login-content">
    <label>Login with @odds.team</label>
    <button v-on:click="signIn">Login</button>
    <button v-on:click="signInV2">Login V2</button>
  </div>
</template>
<script>
export default {
  name: "login",
  data() {
    return {
      profile: null,
      responses: null
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
          this.checkUser();
        })
        .catch(error => {
          window.console.log(error);
        });
    },
    checkUser: function() {
      this.$http
        .post(process.env.VUE_APP_API + "/userData", {
          name: this.profile.ig,
          email: this.profile.U3,
          imgURL: this.profile.Paa
        })
        .then(response => {
          this.responses = response.body;
          window.console.log(this.responses);
          localStorage.setItem("userId", this.responses.id);
          localStorage.setItem("name", this.responses.name);
          localStorage.setItem("email", this.responses.email);
          localStorage.setItem("imgURL", this.responses.imgURL);
          window.console.log(localStorage.getItem("userId"));
          this.isSignIn = this.$gAuth.isAuthorized;
          this.$emit("refreshMyItem");
          this.$emit("refreshNav");
          this.$router.push("/home");
        });
    },
    signInV2: function() {
      window.location.href = "https://api-dev.odds.team/api/opp/v1/login";
    }
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
