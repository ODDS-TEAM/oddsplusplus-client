<template>
  <div class="login-layout">
    <div class="login-content">
      <div class="content-layout">
        <h2>Login with @odds.team</h2>
        <button v-on:click="signIn" class="btn-signIn">Sign In wiht ODDS team</button>
        <!-- <button v-on:click="signInV2">Login V2</button> -->
      </div>
    </div>
  </div>
</template>
<script>
import { Login, parseJwt, Register } from "../service";
export default {
  name: "login",
  data() {
    return {
      profile: null,
      responses: null,
      auth: null,
      user: {
        name: null,
        imgUrl: null
      }
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
          this.auth = GoogleUser.getAuthResponse();
          this.profile = GoogleUser.getBasicProfile();
          if (this.isOddsTeam(this.profile.U3)) {
            localStorage.setItem("userId", GoogleUser.getId());
            localStorage.setItem("name", this.profile.ig);
            localStorage.setItem("email", this.profile.U3);
            localStorage.setItem("imgURL", this.profile.Paa);
            window.localStorage.setItem("profile", this.profile);

            Login(GoogleUser.getAuthResponse().id_token).then(res => {
              window.console.log(res);
              const token = res.data.token;
              sessionStorage.setItem("token", "Bearer " + token);
              localStorage.setItem("userId", parseJwt(token));
              this.user.name = localStorage.getItem("name");
              this.user.imgUrl = localStorage.getItem("imgURL");
              Register(this.user).then(res => {
                window.console.log(res);
              });
            });

            //this.checkUser();

            //window.location.href= "/home"
          } else {
            alert("Sign Fail");
          }
          // console.log(Object.keys(this.profile))
        })
        .catch(error => {
          window.console.log(error);
        });
    },
    checkUser: function() {
      // this.$http
      //   .post(process.env.VUE_APP_API + "/userData", {
      //     name: this.profile.ig,
      //     email: this.profile.U3,
      //     imgURL: this.profile.Paa,
      //     token: this.auth.access_token
      //   })
      //   .then(response => {
      //     window.console.log(response)
      //     this.responses = response.body;
      //     window.console.log(this.responses);
      //     localStorage.setItem("userId", this.responses.id);
      //     localStorage.setItem("name", this.responses.name);
      //     localStorage.setItem("email", this.responses.email);
      //     localStorage.setItem("imgURL", this.responses.imgURL);
      //     window.console.log(localStorage.getItem("userId"));
      //     this.isSignIn = this.$gAuth.isAuthorized;
      //     this.$emit("refreshMyItem");
      //     this.$emit("refreshNav");
      //     this.$router.push("/home");
      //   });
    },
    signInV2: function() {
      window.location.href = "https://api-dev.odds.team/api/opp/v1/login";
    },
    isOddsTeam: email => {
      const regOddsTeam = new RegExp("(\\w{0,20})(\\b@odds.team\\b)", "g");
      const isOdds = regOddsTeam.exec(email);
      return isOdds;
    }
  }
};
</script>
<style scoped>
.login-content {
  text-align: center;
  position: absolute;
  width: 50%;
  height: auto;
  z-index: 15;
  box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2);
  border-radius: 4px;
}
.content-layout {
  margin-top: 3%;
  margin-bottom: 4%;
}
.btn-signIn {
  margin-top: 2%;
  text-align: center;
  width: auto;
}
.login-layout {
  display: flex;
  justify-content: center;
  margin-top: 10%;
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

function newFunction() {
  '/Users/odds/dev/plus1/frontend-v2/src/service.js';
}
