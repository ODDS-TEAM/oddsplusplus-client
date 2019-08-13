<template>
  <div class="login-content">
    <label>Login with @odds.team</label>
    <button>Login</button>
  </div>
</template>
<script>
export default {
  name: "login"
};
</script>
<style>
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
