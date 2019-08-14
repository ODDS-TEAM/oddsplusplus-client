<template>
  <div class="nav">
    <span>
      <img class src="./../assets/odds_logo.png" />
    </span>
    <div class="main-color add-btn">+</div>
  </div>
</template>

<script>
export default {};
</script>

<style scoped>
* {
  box-sizing: border-box;
}
.nav {
  margin: 0;
  padding: 6px 10px;
  overflow: hidden;
  background-color: #f2f2f2;
  height: 43px;
}
img {
  margin: 2px 0;
  height: 27px;
}
.add-btn {
  float: right;
  text-align: center;
  width: 40px;
  height: 31px;
  font-size: 23px;
  border-radius: 5px;
  color: white;
  font-weight: 900;
}
/* @media only screen and (min-width: 600px) {
  ul {
    height: 64px;
  }
}
@media only screen and (min-width: 768px) {
  .nav {
    height: 64px;
  }
} */
</style>

