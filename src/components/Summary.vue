<template>
  <div class="card">
    <div class="row">
      <div class="col-3 col-s-3 menu">
        <ul align="middle">
          <img class="img-item" src="https://images-na.ssl-images-amazon.com/images/I/51RS76qnkEL._SX385_BO1,204,203,200_.jpg"/>
          <div style="padding-left: 10px" align="left">
          <h4>The Road to Wigan Pier: Large Print (Paperback)</h4>
          <h4>by George Orwell</h4>
          <h1 style="color: red">$ 10.76</h1>
          <h5>Order date: 10/10/2019</h5>
          </div>
        </ul>
      </div>

      <div class="col-6 col-s-9">
        <h3>Total item:
          <span style="color: blue"> 5ea</span>
        </h3>
        <h3>Total price:
          <span style="color: blue">  53.8 USD</span>
        </h3> 
      </div>
    </div>
  </div>
</template>

<script>
export default {};
</script>

<style scoped>
ul {
    padding: 5px;
    margin: 0;
}

.card {
  border-radius: 10px;
  box-shadow: 0 0 15px 0 rgba(0, 0, 0, 0.2);
  transition: 0.3s;
  width: 80%;
  margin: 80px auto;
}
.row::after {
  content: "";
  clear: both;
  display: table;
}

[class*="col-"] {
  float: left;
  padding: 0 15px 0 15px;
}
/* For mobile phones: */
[class*="col-"] {
  width: 100%;
}

.img-item {
  position: relative;
  margin: 0 5% 0 5%;
  max-width: 230px;
  max-height: 240px;
  display: contents;
}

@media only screen and (min-width: 600px) {
  .img-item {
  position: relative;
  margin: 0 5% 0 5%;
  max-width: 230px;
  max-height: 240px;
  display: initial;
  }
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
  .img-item {
  position: relative;
  margin: 0 5% 0 5%;
  max-width: 230px;
  max-height: 240px;
  display: initial;
  }
  /* For desktop: */
  .col-1 {
    width: 8.33%;
  }
  .col-2 {
    width: 16.66%;
  }
  .col-3 {
    width: 40%;
    border-right: inset;
  }
  .col-4 {
    width: 33.33%;
  }
  .col-5 {
    width: 41.66%;
  }
  .col-6 {
    padding-top: 5%;
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